-- ============================================================
-- Loss Ally — Add excluded column to client_tasks
-- Run in: Supabase Dashboard → SQL Editor → New Query
-- Safe to re-run: uses IF NOT EXISTS
-- ============================================================

-- Add the excluded flag (default false = included in client view)
alter table public.client_tasks
  add column if not exists excluded boolean not null default false;
