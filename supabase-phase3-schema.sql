-- ============================================================
-- Loss Ally — Phase 3 Schema: How-To Content Columns
-- Run in: Supabase Dashboard → SQL Editor → New Query
-- Safe to re-run: ADD COLUMN IF NOT EXISTS
-- ============================================================

ALTER TABLE public.tasks
  ADD COLUMN IF NOT EXISTS steps      text[],        -- numbered how-to steps (may contain HTML)
  ADD COLUMN IF NOT EXISTS tip        text,          -- helpful tip callout
  ADD COLUMN IF NOT EXISTS warn       text,          -- warning callout
  ADD COLUMN IF NOT EXISTS exec_note  text,          -- executor-specific note
  ADD COLUMN IF NOT EXISTS states     jsonb,         -- [{state, detail, notable?}]
  ADD COLUMN IF NOT EXISTS template   text;          -- name of matching letter template, if any
