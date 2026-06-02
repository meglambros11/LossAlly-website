/*
 * ════════════════════════════════════════════════════════════════════════════
 * LOSS ALLY CLIENT PORTAL — SUPABASE SETUP GUIDE
 * ════════════════════════════════════════════════════════════════════════════
 *
 * Before this portal will work, complete these steps in your Supabase project.
 *
 * ─── STEP 1: Credentials ────────────────────────────────────────────────────
 * 1. Go to https://supabase.com → open your project → Settings → API
 * 2. Copy "Project URL"       → paste into config.js as SUPABASE_URL
 * 3. Copy "anon / public" key → paste into config.js as SUPABASE_ANON_KEY
 *
 * ─── STEP 2: Run this SQL in Supabase SQL Editor ────────────────────────────
 *    (Project → SQL Editor → New Query → paste all of the below → Run)
 *
 * --------------------------------------------------------------------------
 *
 * NOTE: Run the table creation first, then the functions/policies below.
 * The get_my_role() function references profiles, so the table must exist first.
 *
 * -- PART 1: Create the table (run this first)
 * create table if not exists public.profiles (
 *   id          uuid        primary key references auth.users on delete cascade,
 *   full_name   text        not null default '',
 *   email       text,
 *   role        text        not null default 'client'
 *                           check (role in ('client', 'advisor')),
 *   advisor_id  uuid        references public.profiles(id) on delete set null,
 *   notes       text        default '',
 *   created_at  timestamptz default now(),
 *   updated_at  timestamptz default now()
 * );
 *
 * -- PART 2: Run this after the table is created
 * alter table public.profiles enable row level security;
 *
 * -- Helper: returns current user's role (avoids recursive RLS policies)
 * create or replace function public.get_my_role()
 * returns text language sql stable security definer
 * set search_path = public as $$
 *   select role from public.profiles where id = auth.uid()
 * $$;
 *
 * -- Users can read their own profile
 * create policy "view_own_profile"
 *   on public.profiles for select
 *   using (auth.uid() = id);
 *
 * -- Advisors can read all profiles
 * create policy "advisors_view_all"
 *   on public.profiles for select
 *   using (public.get_my_role() = 'advisor');
 *
 * -- Users can update their own profile
 * create policy "update_own_profile"
 *   on public.profiles for update
 *   using (auth.uid() = id);
 *
 * -- Advisors can update any profile (add notes, assign clients)
 * create policy "advisors_update_all"
 *   on public.profiles for update
 *   using (public.get_my_role() = 'advisor');
 *
 * -- Allow the trigger below to insert profiles on user creation
 * create policy "service_insert"
 *   on public.profiles for insert
 *   with check (true);
 *
 * -- Auto-create a profile row whenever a new auth user is created
 * create or replace function public.handle_new_user()
 * returns trigger language plpgsql security definer
 * set search_path = public as $$
 * begin
 *   insert into public.profiles (id, full_name, email, role)
 *   values (
 *     new.id,
 *     coalesce(new.raw_user_meta_data->>'full_name', split_part(new.email, '@', 1)),
 *     new.email,
 *     coalesce(new.raw_user_meta_data->>'role', 'client')
 *   );
 *   return new;
 * end; $$;
 *
 * drop trigger if exists on_auth_user_created on auth.users;
 * create trigger on_auth_user_created
 *   after insert on auth.users
 *   for each row execute procedure public.handle_new_user();
 *
 * -- Keep updated_at current automatically
 * create or replace function public.set_updated_at()
 * returns trigger language plpgsql as $$
 * begin new.updated_at = now(); return new; end; $$;
 *
 * drop trigger if exists profiles_updated_at on public.profiles;
 * create trigger profiles_updated_at
 *   before update on public.profiles
 *   for each row execute procedure public.set_updated_at();
 *
 * --------------------------------------------------------------------------
 *
 * ─── STEP 3: Configure Auth Settings ────────────────────────────────────────
 * Authentication → Settings in your Supabase dashboard:
 *   • Site URL:       https://lossally.com
 *   • Redirect URLs:  add https://lossally.com/portal.html
 *   • Confirm email:  can be DISABLED since advisors hand-create accounts
 *                     and share credentials with clients directly
 *
 * ─── STEP 4: Create accounts (no self-registration) ─────────────────────────
 * All accounts are created by advisors:
 *   1. Authentication → Users → "Add user" → "Create new user"
 *   2. Enter client email + temporary password
 *   3. Send credentials to the client (the portal login note explains this)
 *
 * To promote a user to advisor, run in SQL Editor:
 *   UPDATE public.profiles SET role = 'advisor'
 *   WHERE email = 'advisor@lossally.com';
 *
 * The trigger defaults every new user to 'client', so advisors must be
 * promoted manually after account creation.
 *
 * ════════════════════════════════════════════════════════════════════════════
 */

import { createClient } from 'https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2/+esm'
import { SUPABASE_URL, SUPABASE_ANON_KEY } from './config.js'

export const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY)

// ─── Session & Profile ───────────────────────────────────────────────────────

export async function getSession() {
  const { data: { session } } = await supabase.auth.getSession()
  return session
}

export async function getProfile() {
  const { data: { user } } = await supabase.auth.getUser()
  if (!user) return null
  const { data } = await supabase
    .from('profiles')
    .select('*')
    .eq('id', user.id)
    .single()
  return data
}

// ─── Auth Actions ────────────────────────────────────────────────────────────

export async function signIn(email, password) {
  return supabase.auth.signInWithPassword({ email, password })
}

export async function signOut() {
  await supabase.auth.signOut()
  window.location.replace('portal.html')
}

export async function sendPasswordReset(email) {
  return supabase.auth.resetPasswordForEmail(email, {
    redirectTo: `${window.location.origin}/portal.html`,
  })
}

export async function updatePassword(newPassword) {
  return supabase.auth.updateUser({ password: newPassword })
}

// ─── Route Guards ────────────────────────────────────────────────────────────

// Redirects to portal.html if not logged in. Returns { session, profile } if ok.
export async function requireAuth() {
  const session = await getSession()
  if (!session) {
    window.location.replace('portal.html')
    return null
  }
  const profile = await getProfile()
  return { session, profile }
}

// Redirects to portal-dashboard.html if not an advisor.
export async function requireAdvisor() {
  const auth = await requireAuth()
  if (!auth) return null
  if (auth.profile?.role !== 'advisor') {
    window.location.replace('portal-dashboard.html')
    return null
  }
  return auth
}
