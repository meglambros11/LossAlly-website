-- ============================================================
-- Loss Ally — Phase 2 Schema
-- Run in: Supabase Dashboard → SQL Editor → New Query
-- Safe to re-run: uses IF NOT EXISTS and DROP IF EXISTS
-- ============================================================


-- ── 1. Add plan column to profiles ──────────────────────────
alter table public.profiles
  add column if not exists plan text not null default 'guided'
  check (plan in ('guided', 'supported', 'full_service'));


-- ── 2. Tasks table (shared template) ────────────────────────
create table if not exists public.tasks (
  id          uuid    primary key default gen_random_uuid(),
  title       text    not null,
  category    text    not null,
  priority    text    not null
              check (priority in ('Urgent', 'Month 1', 'Months 2-6', 'Long-Term')),
  sort_order  integer not null,
  is_template boolean not null default true,
  constraint tasks_sort_order_unique unique (sort_order)
);

alter table public.tasks enable row level security;

-- All authenticated users can read template tasks
drop policy if exists "authenticated_read_tasks" on public.tasks;
create policy "authenticated_read_tasks"
  on public.tasks for select
  to authenticated
  using (true);


-- ── 3. Client Tasks table ────────────────────────────────────
create table if not exists public.client_tasks (
  id          uuid        primary key default gen_random_uuid(),
  client_id   uuid        not null references public.profiles(id) on delete cascade,
  task_id     uuid        not null references public.tasks(id) on delete cascade,
  done        boolean     not null default false,
  notes       text        not null default '',
  updated_at  timestamptz not null default now(),
  constraint client_tasks_unique unique (client_id, task_id)
);

alter table public.client_tasks enable row level security;

-- Clients: read their own rows
drop policy if exists "clients_select_own_tasks" on public.client_tasks;
create policy "clients_select_own_tasks"
  on public.client_tasks for select
  using (auth.uid() = client_id);

-- Clients: insert their own rows (used for first-login seeding)
drop policy if exists "clients_insert_own_tasks" on public.client_tasks;
create policy "clients_insert_own_tasks"
  on public.client_tasks for insert
  with check (auth.uid() = client_id);

-- Clients: update their own rows (UI enforces plan-level restrictions)
drop policy if exists "clients_update_own_tasks" on public.client_tasks;
create policy "clients_update_own_tasks"
  on public.client_tasks for update
  using (auth.uid() = client_id);

-- Advisors: read all client_tasks
drop policy if exists "advisors_select_all_tasks" on public.client_tasks;
create policy "advisors_select_all_tasks"
  on public.client_tasks for select
  using (public.get_my_role() = 'advisor');

-- Advisors: update any client_task (for supported/full_service plan management)
drop policy if exists "advisors_update_all_tasks" on public.client_tasks;
create policy "advisors_update_all_tasks"
  on public.client_tasks for update
  using (public.get_my_role() = 'advisor');

-- Advisors: insert for any client (for manual seeding if needed)
drop policy if exists "advisors_insert_all_tasks" on public.client_tasks;
create policy "advisors_insert_all_tasks"
  on public.client_tasks for insert
  with check (public.get_my_role() = 'advisor');

-- Auto-update updated_at on every change
drop trigger if exists client_tasks_updated_at on public.client_tasks;
create trigger client_tasks_updated_at
  before update on public.client_tasks
  for each row execute procedure public.set_updated_at();
