-- ============================================================
-- Loss Ally — Phase 2 RLS Fix
-- Run in: Supabase Dashboard → SQL Editor → New Query
-- Safe to re-run: every CREATE POLICY is preceded by DROP IF EXISTS
-- ============================================================
--
-- WHY THIS IS NEEDED
-- The original schema used `to authenticated` in the tasks policy.
-- That role-binding clause can silently fail to fire in some
-- PostgREST/Supabase configurations, leaving RLS enabled but no
-- matching policy — which returns 403 for everyone. This fix
-- replaces it with an explicit `auth.uid() is not null` check,
-- which is unambiguous in all Supabase environments.
--
-- The advisor check is rewritten as a direct inline subquery
-- instead of calling get_my_role(), so it works even if that
-- helper function was not yet created.
-- ============================================================


-- ══════════════════════════════════════════════════════════════
-- TABLE: tasks
-- No sensitive data — any authenticated user may read all rows.
-- ══════════════════════════════════════════════════════════════

-- Drop every known name for this policy (old name + new name)
drop policy if exists "authenticated_read_tasks" on public.tasks;
drop policy if exists "tasks_select"             on public.tasks;

create policy "tasks_select"
  on public.tasks
  for select
  using (auth.uid() is not null);


-- ══════════════════════════════════════════════════════════════
-- TABLE: client_tasks
-- ══════════════════════════════════════════════════════════════

-- ── SELECT ────────────────────────────────────────────────────

-- Drop both old and new policy names
drop policy if exists "clients_select_own_tasks"   on public.client_tasks;
drop policy if exists "advisors_select_all_tasks"  on public.client_tasks;
drop policy if exists "client_tasks_select_own"    on public.client_tasks;
drop policy if exists "client_tasks_select_advisor" on public.client_tasks;

-- Clients see only their own rows
create policy "client_tasks_select_own"
  on public.client_tasks
  for select
  using (auth.uid() = client_id);

-- Advisors see every row.
-- Uses an inline subquery against profiles (the user always has
-- permission to read their own profile row under profiles RLS).
create policy "client_tasks_select_advisor"
  on public.client_tasks
  for select
  using (
    (select role from public.profiles where id = auth.uid()) = 'advisor'
  );


-- ── INSERT ────────────────────────────────────────────────────

drop policy if exists "clients_insert_own_tasks"  on public.client_tasks;
drop policy if exists "advisors_insert_all_tasks" on public.client_tasks;
drop policy if exists "client_tasks_insert_own"   on public.client_tasks;
drop policy if exists "client_tasks_insert_advisor" on public.client_tasks;

-- Clients may insert their own rows (first-login seeding)
create policy "client_tasks_insert_own"
  on public.client_tasks
  for insert
  with check (auth.uid() = client_id);

-- Advisors may insert rows for any client
create policy "client_tasks_insert_advisor"
  on public.client_tasks
  for insert
  with check (
    (select role from public.profiles where id = auth.uid()) = 'advisor'
  );


-- ── UPDATE ────────────────────────────────────────────────────

drop policy if exists "clients_update_own_tasks"  on public.client_tasks;
drop policy if exists "advisors_update_all_tasks" on public.client_tasks;
drop policy if exists "client_tasks_update_own"   on public.client_tasks;
drop policy if exists "client_tasks_update_advisor" on public.client_tasks;

-- Clients may update their own rows (UI enforces plan restrictions)
create policy "client_tasks_update_own"
  on public.client_tasks
  for update
  using (auth.uid() = client_id);

-- Advisors may update any row (for supported/full_service plan management)
create policy "client_tasks_update_advisor"
  on public.client_tasks
  for update
  using (
    (select role from public.profiles where id = auth.uid()) = 'advisor'
  );


-- ══════════════════════════════════════════════════════════════
-- VERIFY
-- Run these two queries after applying the fix.
-- Both should return rows without a permissions error.
--   select * from public.tasks limit 5;
--   select * from public.client_tasks limit 5;
-- ══════════════════════════════════════════════════════════════
