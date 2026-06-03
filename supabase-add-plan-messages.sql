-- ============================================================
-- Loss Ally — Add plan column + advisor_messages table
-- Run in: Supabase Dashboard → SQL Editor → New Query
-- Safe to re-run: uses IF NOT EXISTS / DO blocks
-- ============================================================

-- 1. Add plan column to profiles (existing clients default to 'guided')
alter table public.profiles
  add column if not exists plan text not null default 'guided';

-- 2. Create advisor_messages table (stores the advisor ↔ client thread)
create table if not exists public.advisor_messages (
  id          uuid        primary key default gen_random_uuid(),
  client_id   uuid        not null references public.profiles(id) on delete cascade,
  sender_role text        not null check (sender_role in ('advisor', 'client')),
  body        text        not null,
  created_at  timestamptz default now()
);

alter table public.advisor_messages enable row level security;

-- RLS policies
do $$
begin
  if not exists (select 1 from pg_policies where schemaname='public' and tablename='advisor_messages' and policyname='client_view_own_messages') then
    execute $p$ create policy "client_view_own_messages" on public.advisor_messages for select using (auth.uid() = client_id) $p$;
  end if;
  if not exists (select 1 from pg_policies where schemaname='public' and tablename='advisor_messages' and policyname='client_insert_own_messages') then
    execute $p$ create policy "client_insert_own_messages" on public.advisor_messages for insert with check (auth.uid() = client_id and sender_role = 'client') $p$;
  end if;
  if not exists (select 1 from pg_policies where schemaname='public' and tablename='advisor_messages' and policyname='advisor_view_all_messages') then
    execute $p$ create policy "advisor_view_all_messages" on public.advisor_messages for select using (public.get_my_role() = 'advisor') $p$;
  end if;
  if not exists (select 1 from pg_policies where schemaname='public' and tablename='advisor_messages' and policyname='advisor_insert_messages') then
    execute $p$ create policy "advisor_insert_messages" on public.advisor_messages for insert with check (public.get_my_role() = 'advisor' and sender_role = 'advisor') $p$;
  end if;
end $$;

-- Service role access (also ensures the profiles grant from the previous fix is in place)
grant select, insert on public.advisor_messages to service_role;
grant select, insert, update on public.profiles to service_role;
