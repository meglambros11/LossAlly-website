-- ============================================================
-- Loss Ally — Grant table access to authenticated role
-- Run in: Supabase Dashboard → SQL Editor → New Query
-- Safe to re-run: GRANT is idempotent
-- ============================================================

-- Allow logged-in clients to read and send messages
-- (RLS policies on advisor_messages restrict what each user can actually see)
grant select, insert on public.advisor_messages to authenticated;
