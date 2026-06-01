-- Prevent duplicate notifications per user, type and match (Module 6.5)
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM pg_constraint
        WHERE conname = 'notifications_user_type_match_key'
    ) THEN
        ALTER TABLE notifications
        ADD CONSTRAINT notifications_user_type_match_key
        UNIQUE (user_id, type, related_match_id);
    END IF;
END $$;
