-- ============================================================
-- Loss Ally — Add is_read_by_advisor column to advisor_messages
-- Run in: Supabase Dashboard → SQL Editor → New Query
-- Safe to re-run: uses IF NOT EXISTS
-- ============================================================

alter table public.advisor_messages
  add column if not exists is_read_by_advisor boolean not null default false;

-- Allow service role to update (needed for mark-read endpoint)
grant select, insert, update on public.advisor_messages to service_role;
