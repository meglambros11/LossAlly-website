-- ============================================================
-- Loss Ally — Add client_details to profiles
-- Run in: Supabase Dashboard → SQL Editor → New Query
-- Safe to re-run: ADD COLUMN IF NOT EXISTS
-- ============================================================

-- Add client_details column to store estate-specific info
-- used to auto-fill letter templates.
-- Shape: {
--   deceased_full_name: string,
--   date_of_death: string (YYYY-MM-DD),
--   executor_name: string,
--   executor_address: string,
--   executor_email: string,
--   executor_phone: string,
--   estate_state: string
-- }
ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS client_details jsonb;

-- Allow authenticated users to update their own client_details
-- (RLS on profiles already exists; add update policy if not present)
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_policies
    WHERE schemaname = 'public'
      AND tablename = 'profiles'
      AND policyname = 'users_update_own_profile'
  ) THEN
    EXECUTE $policy$
      CREATE POLICY "users_update_own_profile"
        ON public.profiles FOR UPDATE
        USING (auth.uid() = id)
        WITH CHECK (auth.uid() = id)
    $policy$;
  END IF;
END $$;
