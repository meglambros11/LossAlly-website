-- ============================================================
-- Loss Ally — Add exec_required + exec_note to tasks
-- Run in: Supabase Dashboard → SQL Editor → New Query
-- Safe to re-run: uses IF NOT EXISTS / idempotent UPDATEs
-- ============================================================

-- Add columns
alter table public.tasks
  add column if not exists exec_required boolean not null default false,
  add column if not exists exec_note text;

-- Mark all executor-required tasks
update public.tasks set exec_required = true
where sort_order in (7,8,9,12,13,14,15,16,29,31,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59);

-- Set exec_note text for the tasks that have explanatory copy
update public.tasks set exec_note =
  'Only the executor or court-appointed administrator can sign and file this return on behalf of the deceased.'
where sort_order = 7;

update public.tasks set exec_note =
  'Only the executor can apply for the estate EIN, as they are responsible for the estate''s tax obligations.'
where sort_order = 8;

update public.tasks set exec_note =
  'The executor signs Form 1041 as the fiduciary responsible for the estate.'
where sort_order = 9;

update public.tasks set exec_note =
  'Only the named executor (or proposed administrator) can file the petition and be appointed. Your advisor can prepare all documents for you to review and sign.'
where sort_order = 12;

update public.tasks set exec_note =
  'Only the appointed executor can possess and use Letters Testamentary. Your advisor holds no legal authority under these letters.'
where sort_order = 13;

update public.tasks set exec_note =
  'The executor is personally responsible for proper notification. Failure to notify can expose the executor to personal liability.'
where sort_order = 14;

update public.tasks set exec_note =
  'The executor signs and files the inventory with the probate court. This is a formal legal document.'
where sort_order = 15;

update public.tasks set exec_note =
  'The executor is personally liable for improper distributions. Never distribute before all debts and taxes are settled.'
where sort_order = 16;

update public.tasks set exec_note =
  'Decisions about selling or refinancing the mortgaged property require the executor''s authority.'
where sort_order = 29;

update public.tasks set exec_note =
  'Only the executor can sign the deed transferring real property from the estate. This step cannot be delegated.'
where sort_order = 31;
