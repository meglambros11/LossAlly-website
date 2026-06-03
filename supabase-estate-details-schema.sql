-- ════════════════════════════════════════════════════════════════════════════
-- ESTATE DETAILS TABLE
-- Run in Supabase SQL Editor after the base schema and phase-2 schema.
-- Stores detailed estate information collected from supported/full_service
-- clients after their service agreement is signed.
-- ════════════════════════════════════════════════════════════════════════════

create table if not exists public.estate_details (
  id               uuid        default gen_random_uuid() primary key,
  client_id        uuid        not null unique references public.profiles(id) on delete cascade,
  created_at       timestamptz default now(),
  updated_at       timestamptz default now(),

  -- Step 1: Personal Identification
  deceased_dob          date,
  deceased_ssn          text,
  deceased_dl_state     text,
  deceased_dl_number    text,
  deceased_medicare_id  text,

  -- Step 2: Legal & Beneficiaries
  will_location         text,
  has_attorney          boolean,
  attorney_name         text,
  attorney_contact      text,
  beneficiaries         jsonb   default '[]'::jsonb,
  -- [{name, relationship, contact}]

  -- Step 3: Financial Accounts
  bank_accounts         jsonb   default '[]'::jsonb,
  -- [{institution, account_number, account_type}]
  life_insurance        jsonb   default '[]'::jsonb,
  -- [{company, policy_number, beneficiary}]
  retirement_accounts   jsonb   default '[]'::jsonb,
  -- [{institution, account_number, plan_type}]
  investment_accounts   jsonb   default '[]'::jsonb,
  -- [{institution, account_number}]

  -- Step 4: Property, Vehicles & Utilities
  properties            jsonb   default '[]'::jsonb,
  -- [{address}]
  mortgage_servicer     text,
  mortgage_loan_number  text,
  landlord_contact      text,
  vehicles              jsonb   default '[]'::jsonb,
  -- [{year, make, model, vin}]
  vehicle_lease_info    text,
  utility_electric      jsonb,
  -- {provider, account_number}
  utility_gas           jsonb,
  utility_water         jsonb,
  utility_internet      jsonb,
  cell_carrier          text,
  cell_account_number   text,

  -- Step 5: Digital Accounts, Insurance & Tax
  email_addresses       text,
  social_media_accounts text,
  apple_id_email        text,
  subscriptions         text,
  health_ins_carrier    text,
  health_ins_member_id  text,
  cpa_name              text,
  cpa_contact           text,
  prior_tax_location    text,
  crypto_info           text,
  loyalty_programs      text,
  professional_memberships text,
  additional_notes      text
);

-- ── Privileges ──────────────────────────────────────────────────────────────
-- RLS policies alone are not enough — Supabase also requires explicit grants
-- to the authenticated role before any operation is allowed.

grant select, insert, update on public.estate_details to authenticated;

-- ── Row Level Security ───────────────────────────────────────────────────────

alter table public.estate_details enable row level security;

-- Clients can view their own row
create policy "estate_details_client_select"
  on public.estate_details for select
  using (auth.uid() = client_id);

-- Clients can insert their own row
create policy "estate_details_client_insert"
  on public.estate_details for insert
  with check (auth.uid() = client_id);

-- Clients can update their own row
create policy "estate_details_client_update"
  on public.estate_details for update
  using (auth.uid() = client_id);

-- Advisors can view all rows
create policy "estate_details_advisor_select"
  on public.estate_details for select
  using (public.get_my_role() = 'advisor');

-- Advisors can update any row (to make corrections)
create policy "estate_details_advisor_update"
  on public.estate_details for update
  using (public.get_my_role() = 'advisor');

-- ── Auto-update updated_at ───────────────────────────────────────────────────

create trigger estate_details_updated_at
  before update on public.estate_details
  for each row execute procedure public.set_updated_at();
