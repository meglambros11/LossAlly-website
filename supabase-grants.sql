-- ============================================================
-- Loss Ally — Table Permission Grants
-- Run in: Supabase Dashboard → SQL Editor → New Query
--
-- WHY THIS IS NEEDED
-- RLS policies control which ROWS a role can access, but the
-- role must first have table-level permission before Postgres
-- even evaluates RLS. Tables created via the SQL Editor do not
-- automatically get grants — you must add them manually.
-- Error code 42501 ("permission denied for table X") means
-- this file has not been run yet.
-- ============================================================

-- ── Schema access ────────────────────────────────────────────
grant usage on schema public to anon, authenticated;

-- ── profiles ─────────────────────────────────────────────────
-- authenticated users: read own row, update own row
-- anon: no access (unauthenticated users never touch profiles)
grant select, insert, update on public.profiles to authenticated;

-- ── tasks (template checklist) ───────────────────────────────
-- All authenticated users may read the shared task list.
-- No writes from the browser — tasks are managed in SQL only.
grant select on public.tasks to authenticated;

-- ── client_tasks ─────────────────────────────────────────────
-- Clients read/write their own rows (seeding + checkbox updates).
-- Advisors read/write all rows (handled by RLS policy, not grants).
grant select, insert, update on public.client_tasks to authenticated;

-- ── Verify ───────────────────────────────────────────────────
-- Run these after applying grants — all should return rows:
--   select * from public.profiles limit 1;
--   select * from public.tasks limit 1;
--   select * from public.client_tasks limit 1;
