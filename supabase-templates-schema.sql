-- ============================================================
-- Loss Ally — Templates Table
-- Run in: Supabase Dashboard → SQL Editor → New Query
-- Safe to re-run: uses IF NOT EXISTS and DROP IF EXISTS
-- ============================================================

CREATE TABLE IF NOT EXISTS public.templates (
  id           uuid    PRIMARY KEY DEFAULT gen_random_uuid(),
  name         text    NOT NULL,
  category     text    NOT NULL,
  type         text    NOT NULL CHECK (type IN ('letter', 'guide')),
  content      text    NOT NULL,
  subject_line text,
  tags         text[]
);

ALTER TABLE public.templates ENABLE ROW LEVEL SECURITY;

-- Authenticated users can read all templates
DROP POLICY IF EXISTS "authenticated_read_templates" ON public.templates;
CREATE POLICY "authenticated_read_templates"
  ON public.templates FOR SELECT
  TO authenticated
  USING (true);

-- Grant SELECT to authenticated role (required in addition to the RLS policy)
GRANT SELECT ON public.templates TO authenticated;

-- No INSERT/UPDATE/DELETE policies are granted to any application role.
-- Only the postgres superuser role may modify template data.
-- This is enforced by the absence of insert/update/delete policies.
