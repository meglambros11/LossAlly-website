-- ============================================================
-- Loss Ally — Intake Submissions Table
-- Run in: Supabase Dashboard → SQL Editor → New Query
-- Safe to re-run: uses IF NOT EXISTS
-- ============================================================

CREATE TABLE IF NOT EXISTS public.intake_submissions (
  id                  uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  submitted_at        timestamptz NOT NULL DEFAULT now(),

  -- Deceased
  deceased_first_name text,
  deceased_last_name  text,
  date_of_passing     date,
  city_of_death       text,
  state               text,

  -- Executor / contact (the person filling the form)
  first_name          text,
  last_name           text,
  email               text,
  phone               text,
  relationship        text,

  -- Estate situation
  executor_status     text,
  will_or_trust       text,
  attorney_status     text,
  capacity            text,
  assets              text[],
  stage               text,
  family_involvement  text,
  distance            text,

  -- Free-text answers
  how_doing           text,
  consultation_goal   text,
  anything_else       text,

  -- Scheduling preferences
  availability        text[],  -- multiple selections allowed
  timezone            text,
  referral_source     text,

  -- Advisor workflow tracking
  status              text NOT NULL DEFAULT 'new'
                      CHECK (status IN ('new','contacted','consultation_scheduled','client','not_proceeding')),
  advisor_notes       text,

  -- Linked to a profile once the client is onboarded
  profile_id          uuid REFERENCES public.profiles(id) ON DELETE SET NULL
);

ALTER TABLE public.intake_submissions ENABLE ROW LEVEL SECURITY;

-- Only advisors can read and update intake submissions
DROP POLICY IF EXISTS "advisors_read_intake" ON public.intake_submissions;
CREATE POLICY "advisors_read_intake"
  ON public.intake_submissions FOR SELECT
  USING (public.get_my_role() = 'advisor');

DROP POLICY IF EXISTS "advisors_update_intake" ON public.intake_submissions;
CREATE POLICY "advisors_update_intake"
  ON public.intake_submissions FOR UPDATE
  USING (public.get_my_role() = 'advisor');

-- The Cloudflare Worker inserts via the service role key, which bypasses RLS.
-- No INSERT policy is needed for application roles.

GRANT SELECT, UPDATE ON public.intake_submissions TO authenticated;
