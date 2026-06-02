-- ============================================================
-- Loss Ally — Estate Checklist: 59 Template Tasks
-- Run AFTER supabase-phase2-schema.sql
-- Safe to re-run: ON CONFLICT (sort_order) DO NOTHING
-- ============================================================

insert into public.tasks (title, category, priority, sort_order) values

-- ── Government & Benefits ─────────────────────────────────────────────────────
('Notify Social Security Administration',
 'Government & Benefits', 'Urgent', 1),

('Apply for SSA Survivor Benefits',
 'Government & Benefits', 'Urgent', 2),

('Obtain Certified Death Certificates',
 'Government & Benefits', 'Urgent', 3),

('Notify Medicare and Medicaid',
 'Government & Benefits', 'Urgent', 4),

('Notify Veterans Affairs',
 'Government & Benefits', 'Month 1', 5),

('Cancel Driver''s License at DMV',
 'Government & Benefits', 'Month 1', 6),

('File Final Federal Income Tax Return IRS Form 1040',
 'Government & Benefits', 'Months 2-6', 7),

('Obtain Estate EIN from IRS',
 'Government & Benefits', 'Months 2-6', 8),

('File Estate Income Tax Return IRS Form 1041',
 'Government & Benefits', 'Long-Term', 9),

-- ── Legal & Probate ───────────────────────────────────────────────────────────
('Locate and Secure the Original Will',
 'Legal & Probate', 'Urgent', 10),

('Determine Whether Probate Is Required',
 'Legal & Probate', 'Urgent', 11),

('File the Will with Probate Court and Open Probate',
 'Legal & Probate', 'Month 1', 12),

('Petition for Letters Testamentary or Letters of Administration',
 'Legal & Probate', 'Month 1', 13),

('Notify Beneficiaries and Heirs',
 'Legal & Probate', 'Month 1', 14),

('Compile Full Estate Asset Inventory',
 'Legal & Probate', 'Months 2-6', 15),

('Distribute Assets to Heirs',
 'Legal & Probate', 'Long-Term', 16),

-- ── Financial Accounts ────────────────────────────────────────────────────────
('Inventory All Financial Accounts',
 'Financial Accounts', 'Urgent', 17),

('Cancel or Pause Auto-Draft Payments',
 'Financial Accounts', 'Urgent', 18),

('Notify All Banks and Credit Unions',
 'Financial Accounts', 'Month 1', 19),

('Contact All Credit Card Companies',
 'Financial Accounts', 'Month 1', 20),

('File Life Insurance Claims',
 'Financial Accounts', 'Month 1', 21),

('Contact Pension and Defined Benefit Plan Administrator',
 'Financial Accounts', 'Month 1', 22),

('Contact 401k IRA and Retirement Account Administrators',
 'Financial Accounts', 'Month 1', 23),

('Contact Investment and Brokerage Accounts',
 'Financial Accounts', 'Months 2-6', 24),

-- ── Property & Home ───────────────────────────────────────────────────────────
('Secure the Home and Property',
 'Property & Home', 'Urgent', 25),

('Forward Mail to Executor Address',
 'Property & Home', 'Urgent', 26),

('Notify Landlord or Property Manager if Renting',
 'Property & Home', 'Month 1', 27),

('Transfer or Cancel Utilities',
 'Property & Home', 'Month 1', 28),

('Notify Mortgage Servicer',
 'Property & Home', 'Month 1', 29),

('Contact Vehicle Lessor for Any Leased Vehicle',
 'Property & Home', 'Month 1', 30),

('Transfer Real Property Deeds and Vehicle Titles',
 'Property & Home', 'Months 2-6', 31),

-- ── Digital Estate ────────────────────────────────────────────────────────────
('Handle Facebook and Instagram Accounts',
 'Digital Estate', 'Month 1', 32),

('Handle Email Accounts',
 'Digital Estate', 'Month 1', 33),

('Cancel Recurring Digital Subscriptions',
 'Digital Estate', 'Month 1', 34),

('Handle Apple ID and iCloud Account',
 'Digital Estate', 'Months 2-6', 35),

('Locate and Document Cryptocurrency Holdings',
 'Digital Estate', 'Months 2-6', 36),

('Claim Loyalty Points and Airline Miles',
 'Digital Estate', 'Long-Term', 37),

-- ── Personal & Memberships ────────────────────────────────────────────────────
('Cancel Health Insurance Coverage',
 'Personal & Memberships', 'Month 1', 38),

('Handle Prescriptions and Medical Devices',
 'Personal & Memberships', 'Month 1', 39),

('Cancel Gym and Fitness Memberships',
 'Personal & Memberships', 'Month 1', 40),

('Cancel or Transfer Cell Phone and Data Plan',
 'Personal & Memberships', 'Months 2-6', 41),

('Cancel Professional Memberships and Licenses',
 'Personal & Memberships', 'Months 2-6', 42),

-- ── Record Retention ──────────────────────────────────────────────────────────
('Retain Final Form 1040 Seven Years',
 'Record Retention', 'Long-Term', 43),

('Retain Form 1041 Seven Years',
 'Record Retention', 'Long-Term', 44),

('Retain Form 706 if Applicable Seven Years',
 'Record Retention', 'Long-Term', 45),

('Retain All State Tax Returns Seven Years',
 'Record Retention', 'Long-Term', 46),

('Retain Original Will and Codicils Permanently',
 'Record Retention', 'Long-Term', 47),

('Retain Letters Testamentary Permanently',
 'Record Retention', 'Long-Term', 48),

('Retain All Probate Court Filings Permanently',
 'Record Retention', 'Long-Term', 49),

('Retain Estate Asset Inventory Permanently',
 'Record Retention', 'Long-Term', 50),

('Retain Signed Heir Receipts and Releases Permanently',
 'Record Retention', 'Long-Term', 51),

('Retain Real Estate Deeds and Appraisals Permanently — Pass to Heir',
 'Record Retention', 'Long-Term', 52),

('Retain Personal Property Appraisals Until Heir Sells Plus Seven Years — Pass to Heir',
 'Record Retention', 'Long-Term', 53),

('Retain Estate Bank Account Statements Seven Years After Estate Closes',
 'Record Retention', 'Long-Term', 54),

('Retain Investment Statements Seven Years — Pass Copies to Heirs',
 'Record Retention', 'Long-Term', 55),

('Retain Insurance Claim Documentation Seven Years',
 'Record Retention', 'Long-Term', 56),

('Retain Creditor Claim and Settlement Documentation Seven Years',
 'Record Retention', 'Long-Term', 57),

('Retain Attorney CPA and Loss Ally Engagement Records Seven Years',
 'Record Retention', 'Long-Term', 58),

('Pass Record Retention Guide to Every Heir at Closure',
 'Record Retention', 'Long-Term', 59)

on conflict (sort_order) do nothing;

-- Verify: should return 59
-- select count(*) from public.tasks;
