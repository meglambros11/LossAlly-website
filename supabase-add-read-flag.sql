-- ============================================================
-- Loss Ally — Add is_read_by_advisor column to advisor_messages
-- Run in: Supabase Dashboard → SQL Editor → New Query
-- Safe to re-run: uses IF NOT EXISTS
-- ============================================================

alter table public.advisor_messages
  add column if not exists is_read_by_advisor boolean not null default false;

-- Tracks whether the client has seen each advisor message.
-- Used to suppress duplicate email notifications: client only gets emailed
-- when the advisor sends the first message they haven't read yet.
alter table public.advisor_messages
  add column if not exists is_read_by_client boolean not null default false;

-- Allow service role to update (needed for both mark-read endpoints)
grant select, insert, update on public.advisor_messages to service_role;
