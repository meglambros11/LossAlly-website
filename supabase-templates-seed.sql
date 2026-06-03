-- ============================================================
-- Loss Ally — Template Library Seed (from template_library.html)
-- 25 letter templates + 3 extras for task links + 7 form guides
-- Run AFTER supabase-templates-schema.sql
-- Safe to re-run: ON CONFLICT (name) DO UPDATE
-- ============================================================

-- Add unique constraint on name if not already present
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint WHERE conname = 'templates_name_unique'
  ) THEN
    ALTER TABLE public.templates ADD CONSTRAINT templates_name_unique UNIQUE (name);
  END IF;
END $$;

-- ──────────────────────────────────────────────────────────────────────────────
-- GOVERNMENT & BENEFITS — letters
-- ──────────────────────────────────────────────────────────────────────────────

INSERT INTO public.templates (name, category, type, content, tags)
VALUES (
  'SSA Death Notification Letter',
  'Government & Benefits', 'letter',
$TPL$[DATE]

Social Security Administration
[LOCAL SSA OFFICE ADDRESS]
[CITY, STATE, ZIP]

Re: Notice of Death — [DECEASED FULL LEGAL NAME]
Social Security Number: [DECEASED SSN]

To Whom It May Concern:

I am writing to formally notify the Social Security Administration of the death of [DECEASED FULL NAME], who passed away on [DATE OF DEATH] in [CITY, STATE].

The deceased's information is as follows:
  Full Legal Name: [DECEASED FULL NAME]
  Date of Birth:   [DATE OF BIRTH]
  Social Security Number: [SSN]
  Date of Death:   [DATE OF DEATH]

I am the [RELATIONSHIP, e.g. son / daughter / executor] of the deceased. My contact information is:

  Name:    [YOUR FULL NAME]
  Address: [YOUR ADDRESS]
  Phone:   [YOUR PHONE NUMBER]
  Email:   [YOUR EMAIL]

Please take the following actions:

1. Cease all benefit payments effective [DATE OF DEATH]. I understand that any payments deposited after the date of death must be returned and I will cooperate fully with that process.

2. Provide information regarding any survivor benefits for which I or other family members may be eligible.

3. Confirm in writing that the account has been flagged and payments have been stopped.

Enclosed: Certified copy of death certificate.

Please contact me at the information above with any questions or requests for additional documentation.

Sincerely,

[YOUR SIGNATURE]

[YOUR PRINTED NAME]
[YOUR RELATIONSHIP TO DECEASED]
[DATE]$TPL$,
  ARRAY['social security', 'government', 'death notification']
)
ON CONFLICT (name) DO UPDATE
  SET content = EXCLUDED.content, category = EXCLUDED.category,
      type = EXCLUDED.type, tags = EXCLUDED.tags;


INSERT INTO public.templates (name, category, type, content, tags)
VALUES (
  'Social Security — Survivor Benefits Application Cover Letter',
  'Government & Benefits', 'letter',
$TPL$[DATE]

Social Security Administration
[LOCAL SSA OFFICE ADDRESS]
[CITY, STATE, ZIP]

Re: Application for Survivor Benefits
Deceased: [DECEASED FULL NAME], SSN [DECEASED SSN]
Applicant: [YOUR FULL NAME], SSN [YOUR SSN]

Dear Social Security Administration:

I am submitting this application for survivor benefits following the death of my [RELATIONSHIP], [DECEASED FULL NAME], who passed away on [DATE OF DEATH].

Enclosed with this letter, please find:

  [ ] Completed Form [SSA-10 / SSA-5 / SSA-4] — Survivor Benefits Application
  [ ] Certified copy of death certificate
  [ ] Certified copy of marriage certificate — for spouses
  [ ] Certified birth certificate — for child applicants
  [ ] Proof of citizenship or lawful alien status
  [ ] Most recent W-2 or self-employment tax return

My contact information:
  Name:    [YOUR FULL NAME]
  Address: [YOUR ADDRESS]
  Phone:   [YOUR PHONE NUMBER]
  Email:   [YOUR EMAIL]

I request that any correspondence be sent to the address above. Please contact me if you require any additional documentation to process this application.

Thank you for your assistance during this difficult time.

Sincerely,

[YOUR SIGNATURE]

[YOUR PRINTED NAME]
[DATE]$TPL$,
  ARRAY['social security', 'survivor benefits', 'government']
)
ON CONFLICT (name) DO UPDATE
  SET content = EXCLUDED.content, category = EXCLUDED.category,
      type = EXCLUDED.type, tags = EXCLUDED.tags;


INSERT INTO public.templates (name, category, type, content, tags)
VALUES (
  'Medicare & Medicaid Notification Letter',
  'Government & Benefits', 'letter',
$TPL$[DATE]

Medicare / [STATE MEDICAID OFFICE NAME]
[ADDRESS]
[CITY, STATE, ZIP]

Re: Death Notification — [DECEASED FULL NAME]
Medicare / Medicaid ID Number: [ID NUMBER]
Date of Birth: [DATE OF BIRTH]

To the Account Administration Department:

I am writing to notify you of the death of [DECEASED FULL NAME], who passed away on [DATE OF DEATH].

Please take the following actions immediately:
  1. Terminate all coverage effective [DATE OF DEATH].
  2. Cancel any pending referrals, authorizations, or scheduled services.
  3. Provide written confirmation of account termination.
  4. Advise me of any outstanding claims, balances, or amounts owed to or from the estate.

FOR MEDICAID ONLY: I understand that [STATE] may have an estate recovery program and I request that you inform me of any claims the state intends to make against the estate before I make any distributions to heirs.

My contact information:
  Name:    [YOUR FULL NAME]
  Relationship: [RELATIONSHIP TO DECEASED]
  Address: [YOUR ADDRESS]
  Phone:   [YOUR PHONE]

Enclosed: Certified copy of death certificate.

Sincerely,

[YOUR SIGNATURE]
[YOUR PRINTED NAME]
[DATE]$TPL$,
  ARRAY['medicare', 'medicaid', 'government', 'health insurance']
)
ON CONFLICT (name) DO UPDATE
  SET content = EXCLUDED.content, category = EXCLUDED.category,
      type = EXCLUDED.type, tags = EXCLUDED.tags;


INSERT INTO public.templates (name, category, type, content, tags)
VALUES (
  'VA Survivor Benefits Letter',
  'Government & Benefits', 'letter',
$TPL$[DATE]

Department of Veterans Affairs
[VA REGIONAL OFFICE ADDRESS]
[CITY, STATE, ZIP]

Re: Death Notification and Survivor Benefits Inquiry
Veteran: [DECEASED FULL NAME]
VA File Number / SSN: [VA FILE NUMBER OR SSN]
Branch of Service: [BRANCH]
Dates of Service: [FROM] to [TO]

Dear Veterans Affairs:

I am writing to notify you of the death of [DECEASED FULL NAME], a veteran of the [BRANCH OF SERVICE], who passed away on [DATE OF DEATH] in [CITY, STATE].

I am the deceased's [RELATIONSHIP] and am serving as [executor of the estate / primary next of kin].

I respectfully request:

1. Formal confirmation that the veteran's file has been updated to reflect the date of death.
2. Information regarding burial benefits, including burial allowances and grave markers.
3. Information regarding Dependency and Indemnity Compensation (DIC) if the death was [service-connected / potentially service-connected].
4. Information regarding the Survivors Pension program for surviving spouses.
5. A complete accounting of any current benefits that should be terminated.

My contact information:
  Name:    [YOUR FULL NAME]
  Address: [YOUR ADDRESS]
  Phone:   [YOUR PHONE]
  Email:   [YOUR EMAIL]

Enclosed: Certified copy of death certificate, copy of DD-214 (if available).

Thank you for the service of [DECEASED FIRST NAME] and for your assistance.

Sincerely,

[YOUR SIGNATURE]
[YOUR PRINTED NAME]
[DATE]$TPL$,
  ARRAY['veterans affairs', 'VA', 'survivor benefits', 'government']
)
ON CONFLICT (name) DO UPDATE
  SET content = EXCLUDED.content, category = EXCLUDED.category,
      type = EXCLUDED.type, tags = EXCLUDED.tags;


INSERT INTO public.templates (name, category, type, content, tags)
VALUES (
  'DMV Driver''s License Cancellation Letter',
  'Government & Benefits', 'letter',
$TPL$[DATE]

[STATE] Department of Motor Vehicles
[DMV ADDRESS]
[CITY, STATE, ZIP]

Re: Driver's License Cancellation — Death of License Holder
License Number: [LICENSE NUMBER, if known]

To Whom It May Concern:

I am writing to request cancellation of the driver's license of [DECEASED FULL NAME], who passed away on [DATE OF DEATH].

Deceased's Information:
  Full Legal Name: [DECEASED FULL NAME]
  Date of Birth:   [DATE OF BIRTH]
  License Number:  [LICENSE NUMBER, if known]
  Address on License: [ADDRESS]

I am the [RELATIONSHIP] of the deceased. Enclosed, please find:
  [ ] Certified copy of death certificate
  [ ] Original driver's license (if enclosed)

Please confirm cancellation in writing and advise me of any additional steps required, particularly regarding vehicle title transfers.

My contact information:
  Name:    [YOUR FULL NAME]
  Address: [YOUR ADDRESS]
  Phone:   [YOUR PHONE]

Sincerely,

[YOUR SIGNATURE]
[YOUR PRINTED NAME]
[DATE]$TPL$,
  ARRAY['DMV', 'driver license', 'government', 'cancellation']
)
ON CONFLICT (name) DO UPDATE
  SET content = EXCLUDED.content, category = EXCLUDED.category,
      type = EXCLUDED.type, tags = EXCLUDED.tags;


-- ──────────────────────────────────────────────────────────────────────────────
-- FINANCIAL ACCOUNTS — letters
-- ──────────────────────────────────────────────────────────────────────────────

INSERT INTO public.templates (name, category, type, content, tags)
VALUES (
  'Financial Institution Notification Letter',
  'Financial Accounts', 'letter',
$TPL$[DATE]

[BANK / CREDIT UNION NAME]
Estate Services Department
[ADDRESS]
[CITY, STATE, ZIP]

Re: Notification of Death — Account Holder [DECEASED FULL NAME]
Account Number(s): [ACCOUNT NUMBER(S)]

Dear Estate Services Team:

I am writing to notify [BANK NAME] of the death of [DECEASED FULL NAME], who passed away on [DATE OF DEATH].

I am the [RELATIONSHIP / EXECUTOR] of the deceased. My details are:
  Name:    [YOUR FULL NAME]
  Address: [YOUR ADDRESS]
  Phone:   [YOUR PHONE]
  Email:   [YOUR EMAIL]

I request that you:

1. Flag all accounts held in the name of [DECEASED FULL NAME] as deceased.
2. Provide a statement showing the balance in each account as of [DATE OF DEATH] — needed for estate inventory.
3. Advise me of the documentation required to access or close each account.
4. Confirm whether any accounts have a Payable on Death (POD) beneficiary designation and provide instructions for that process.
5. Stop any automatic payments or debits from individual accounts pending estate administration.

IF JOINT ACCOUNT: I am a joint account holder and request that the account be re-titled in my name alone.

Enclosed:
  [ ] Certified copy of death certificate
  [ ] Certified copy of Letters Testamentary, if available
  [ ] Copy of government-issued ID

Please contact me at the information above to confirm receipt and advise on next steps.

Sincerely,

[YOUR SIGNATURE]
[YOUR PRINTED NAME]
[RELATIONSHIP TO DECEASED]
[DATE]$TPL$,
  ARRAY['bank', 'financial institution', 'accounts', 'notification']
)
ON CONFLICT (name) DO UPDATE
  SET content = EXCLUDED.content, category = EXCLUDED.category,
      type = EXCLUDED.type, tags = EXCLUDED.tags;


INSERT INTO public.templates (name, category, type, content, tags)
VALUES (
  'Credit Card Company Notification Letter',
  'Financial Accounts', 'letter',
$TPL$[DATE]

[CREDIT CARD COMPANY NAME]
Customer Service / Estate Administration
[ADDRESS]
[CITY, STATE, ZIP]

Re: Account Cancellation — Death of Account Holder
Account Holder: [DECEASED FULL NAME]
Account Number: [LAST 4 DIGITS or FULL NUMBER]

Dear Estate Administration Team:

I am writing to notify you of the death of [DECEASED FULL NAME], primary account holder, who passed away on [DATE OF DEATH].

I am the [RELATIONSHIP / EXECUTOR] of the deceased and am managing the estate.

Please:

1. Cancel all cards associated with this account, including any authorized user cards, effective immediately.
2. Provide a final statement showing the balance as of [DATE OF DEATH].
3. Confirm the process for resolving any outstanding balance through the estate.
4. Remove the deceased from any joint accounts or confirm my sole liability as the surviving joint cardholder.
5. Confirm in writing that the account has been marked deceased to prevent fraudulent use.

Please note: I am not personally responsible for the balance on an individual account. Outstanding balances will be settled through the estate administration process.

Enclosed: Certified copy of death certificate.

My contact information:
  Name:    [YOUR FULL NAME]
  Relationship: [RELATIONSHIP]
  Address: [YOUR ADDRESS]
  Phone:   [YOUR PHONE]

Sincerely,

[YOUR SIGNATURE]
[YOUR PRINTED NAME]
[DATE]$TPL$,
  ARRAY['credit card', 'financial', 'accounts', 'closure', 'notification']
)
ON CONFLICT (name) DO UPDATE
  SET content = EXCLUDED.content, category = EXCLUDED.category,
      type = EXCLUDED.type, tags = EXCLUDED.tags;


INSERT INTO public.templates (name, category, type, content, tags)
VALUES (
  'Life Insurance Claim Letter',
  'Financial Accounts', 'letter',
$TPL$[DATE]

[INSURANCE COMPANY NAME]
Life Insurance Claims Department
[ADDRESS]
[CITY, STATE, ZIP]

Re: Life Insurance Death Benefit Claim
Insured: [DECEASED FULL NAME]
Policy Number: [POLICY NUMBER]
Date of Death: [DATE OF DEATH]

Dear Claims Department:

I am submitting a claim for the death benefit under the above-referenced life insurance policy. The insured, [DECEASED FULL NAME], passed away on [DATE OF DEATH] in [CITY, STATE].

I am the [PRIMARY BENEFICIARY / EXECUTOR / RELATIONSHIP] named [in the policy / under the terms of the estate].

Enclosed with this letter, please find:
  [ ] Completed death benefit claim form (Form [FORM NUMBER])
  [ ] Certified copy of death certificate
  [ ] Original policy, if required
  [ ] Proof of my identity — government-issued ID
  [ ] Marriage certificate — if claiming as surviving spouse

Please process this claim and advise me of the payment options available. I request payment by [LUMP SUM / CHECK / DIRECT DEPOSIT].

My contact information:
  Name:    [YOUR FULL NAME]
  Address: [YOUR ADDRESS]
  Phone:   [YOUR PHONE]
  Email:   [YOUR EMAIL]
  SSN:     [YOUR SSN — for tax reporting purposes]

If any additional documentation is required, please contact me promptly. I understand that payment is due within [30 / 45] days of receiving a complete claim.

Sincerely,

[YOUR SIGNATURE]
[YOUR PRINTED NAME]
[RELATIONSHIP TO DECEASED / BENEFICIARY STATUS]
[DATE]$TPL$,
  ARRAY['life insurance', 'claim', 'financial', 'insurance']
)
ON CONFLICT (name) DO UPDATE
  SET content = EXCLUDED.content, category = EXCLUDED.category,
      type = EXCLUDED.type, tags = EXCLUDED.tags;


INSERT INTO public.templates (name, category, type, content, tags)
VALUES (
  '401k / IRA Retirement Account Death Notification',
  'Financial Accounts', 'letter',
$TPL$[DATE]

[FINANCIAL INSTITUTION NAME]
Retirement Accounts / Estate Services Department
[ADDRESS]
[CITY, STATE, ZIP]

Re: Death Notification and Beneficiary Claim
Account Holder: [DECEASED FULL NAME]
Account Number: [ACCOUNT NUMBER]
Account Type: [401(k) / Traditional IRA / Roth IRA / 403(b)]

Dear Estate Services:

I am writing to notify you of the death of [DECEASED FULL NAME], who passed away on [DATE OF DEATH].

I am the [PRIMARY BENEFICIARY / EXECUTOR] of this account. My information:
  Name:    [YOUR FULL NAME]
  Address: [YOUR ADDRESS]
  Phone:   [YOUR PHONE]
  SSN:     [YOUR SSN]
  Relationship: [RELATIONSHIP TO DECEASED]

I request that you:

1. Confirm the beneficiary designation currently on file for this account.
2. Provide the current account balance as of [DATE OF DEATH] for estate inventory purposes.
3. Send me all required claim forms to initiate the distribution or transfer process.
4. Advise me of the available options: [direct rollover to my IRA / Inherited IRA / lump sum distribution].

FOR SPOUSE: As the surviving spouse and sole primary beneficiary, I wish to explore a spousal rollover to my own IRA. Please advise on this process.

FOR NON-SPOUSE: As a non-spouse beneficiary, I understand I am required to establish an Inherited IRA and take distributions within 10 years. Please provide instructions.

Enclosed: Certified copy of death certificate, [copy of Letters Testamentary if no named beneficiary].

Sincerely,

[YOUR SIGNATURE]
[YOUR PRINTED NAME]
[DATE]$TPL$,
  ARRAY['401k', 'IRA', 'retirement', 'financial', 'beneficiary claim']
)
ON CONFLICT (name) DO UPDATE
  SET content = EXCLUDED.content, category = EXCLUDED.category,
      type = EXCLUDED.type, tags = EXCLUDED.tags;


INSERT INTO public.templates (name, category, type, content, tags)
VALUES (
  'Pension Administrator Notification Letter',
  'Financial Accounts', 'letter',
$TPL$[DATE]

[PENSION PLAN ADMINISTRATOR / HR DEPARTMENT]
[COMPANY / ORGANIZATION NAME]
[ADDRESS]
[CITY, STATE, ZIP]

Re: Death Notification — Plan Participant [DECEASED FULL NAME]
Employee ID / Plan Number: [ID NUMBER]

Dear Plan Administrator:

I am writing to notify you of the death of [DECEASED FULL NAME], a [current / former] participant in the [PLAN NAME], who passed away on [DATE OF DEATH].

I am the [SPOUSE / BENEFICIARY / EXECUTOR] of the deceased.

I request that you:

1. Confirm the pension elections made by [DECEASED FIRST NAME], specifically whether a joint-and-survivor annuity, pre-retirement survivor benefit, or other survivor option was selected.
2. Provide information on any death benefits payable to surviving beneficiaries.
3. Confirm the process for applying for any survivor annuity or lump sum benefit.
4. Provide a statement of account showing the accrued benefit as of the date of death.
5. Confirm that benefit payments have been stopped and advise whether any payments made after [DATE OF DEATH] must be returned.

My contact information:
  Name:    [YOUR FULL NAME]
  Relationship: [RELATIONSHIP]
  Address: [YOUR ADDRESS]
  Phone:   [YOUR PHONE]

Enclosed: Certified copy of death certificate.

Sincerely,

[YOUR SIGNATURE]
[YOUR PRINTED NAME]
[DATE]$TPL$,
  ARRAY['pension', 'retirement', 'financial', 'survivor benefits', 'notification']
)
ON CONFLICT (name) DO UPDATE
  SET content = EXCLUDED.content, category = EXCLUDED.category,
      type = EXCLUDED.type, tags = EXCLUDED.tags;


INSERT INTO public.templates (name, category, type, content, tags)
VALUES (
  'Brokerage Investment Account Executor Transfer Request',
  'Financial Accounts', 'letter',
$TPL$[DATE]

[BROKERAGE FIRM NAME]
Estate Services Department
[ADDRESS]
[CITY, STATE, ZIP]

Re: Estate of [DECEASED FULL NAME] — Account Transfer / Liquidation
Account Number: [ACCOUNT NUMBER]

Dear Estate Services:

I am the duly appointed Executor of the Estate of [DECEASED FULL NAME], who passed away on [DATE OF DEATH]. I have been granted Letters Testamentary by [COUNTY] [COURT NAME] on [DATE ISSUED].

I am writing to request [transfer of the account assets to the heirs as described below / liquidation of the account and remittance to the estate account].

Account Information:
  Account Holder: [DECEASED FULL NAME]
  Account Number: [ACCOUNT NUMBER]
  Date of Death Value: Please provide a statement as of [DATE OF DEATH]

OPTION A — TRANSFER IN KIND:
Please transfer all holdings to the following beneficiary account:
  Beneficiary: [HEIR NAME]
  Institution: [RECEIVING BROKERAGE]
  Account Number: [RECEIVING ACCOUNT]
  DTC Participant Number: [IF APPLICABLE]

OPTION B — LIQUIDATE AND REMIT:
Please liquidate all holdings and wire proceeds to the estate account:
  Bank: [ESTATE BANK NAME]
  Account Name: Estate of [DECEASED FULL NAME]
  Account Number: [ESTATE ACCOUNT NUMBER]
  Routing Number: [ROUTING NUMBER]

Enclosed:
  [ ] Certified copy of Letters Testamentary
  [ ] Certified copy of death certificate
  [ ] Medallion Signature Guarantee (if required)
  [ ] Completed estate distribution form (if provided by your firm)

Sincerely,

[EXECUTOR SIGNATURE]

[EXECUTOR PRINTED NAME], Executor
Estate of [DECEASED FULL NAME]
[DATE]$TPL$,
  ARRAY['brokerage', 'investment', 'stocks', 'financial', 'executor']
)
ON CONFLICT (name) DO UPDATE
  SET content = EXCLUDED.content, category = EXCLUDED.category,
      type = EXCLUDED.type, tags = EXCLUDED.tags;


-- ──────────────────────────────────────────────────────────────────────────────
-- PROPERTY & HOME — letters
-- ──────────────────────────────────────────────────────────────────────────────

INSERT INTO public.templates (name, category, type, content, tags)
VALUES (
  'Landlord Death Notification Letter',
  'Property & Home', 'letter',
$TPL$[DATE]

[LANDLORD / PROPERTY MANAGEMENT COMPANY]
[ADDRESS]
[CITY, STATE, ZIP]

Re: Notice of Tenant Death and Lease Termination
Tenant: [DECEASED FULL NAME]
Property Address: [RENTAL PROPERTY ADDRESS]
Lease: [LEASE START DATE] to [LEASE END DATE]

Dear [LANDLORD NAME / Property Manager]:

I am writing to formally notify you of the death of [DECEASED FULL NAME], tenant at the above-referenced property. [DECEASED FIRST NAME] passed away on [DATE OF DEATH].

I am the [EXECUTOR OF THE ESTATE / NEXT OF KIN / LEGAL REPRESENTATIVE] of the deceased.

Pursuant to [STATE] law, I am providing this written notice to terminate the lease effective [TERMINATION DATE — typically 30 days from this notice or the end of the current rental period, whichever is applicable per your state].

I request that you:

1. Confirm the effective termination date and any remaining rental obligations of the estate.
2. Schedule a mutually convenient time for a final walkthrough of the property.
3. Return the security deposit of $[AMOUNT], less any legitimate deductions, within the timeframe required by [STATE] law.
4. Advise me of your preferred process for returning keys and personal property removal.

The estate will ensure the property is vacated in good condition by [VACATE DATE]. Please contact me to coordinate.

My contact information:
  Name:    [YOUR FULL NAME]
  Role:    [EXECUTOR / NEXT OF KIN]
  Address: [YOUR ADDRESS]
  Phone:   [YOUR PHONE]
  Email:   [YOUR EMAIL]

Enclosed: Certified copy of death certificate.

Sincerely,

[YOUR SIGNATURE]
[YOUR PRINTED NAME]
[DATE]$TPL$,
  ARRAY['landlord', 'rental', 'lease', 'property', 'notification']
)
ON CONFLICT (name) DO UPDATE
  SET content = EXCLUDED.content, category = EXCLUDED.category,
      type = EXCLUDED.type, tags = EXCLUDED.tags;


INSERT INTO public.templates (name, category, type, content, tags)
VALUES (
  'Mortgage Servicer Notification Letter',
  'Property & Home', 'letter',
$TPL$[DATE]

[MORTGAGE SERVICER NAME]
Loan Administration / Loss Mitigation Department
[ADDRESS]
[CITY, STATE, ZIP]

Re: Notification of Borrower Death
Borrower: [DECEASED FULL NAME]
Loan Number: [LOAN NUMBER]
Property Address: [PROPERTY ADDRESS]

Dear Loan Administration Team:

I am writing to notify you of the death of [DECEASED FULL NAME], borrower on the above-referenced mortgage loan. [DECEASED FIRST NAME] passed away on [DATE OF DEATH].

I am the [EXECUTOR OF THE ESTATE / SURVIVING SPOUSE / HEIR] and am managing the estate.

I request that you:

1. Note the death in your records and update the account accordingly.
2. Advise me of the options available regarding this loan, including: assumption by an heir, sale of the property, or continued payment from estate funds.
3. Provide a current payoff statement as of [DATE], including any fees or prepayment penalties.
4. Confirm the monthly payment amount and due dates so payments can continue without interruption.
5. Advise whether mortgage life insurance is associated with this loan that would satisfy the outstanding balance.

IF SURVIVING CO-BORROWER: I am a co-borrower on this loan and intend to continue making payments. Please update the account to reflect my sole borrower status.

I understand that under the Garn-St Germain Depository Institutions Act, I have the right to assume this mortgage as an heir without the loan being called due.

Enclosed: Certified copy of death certificate, Letters Testamentary if available.

My contact information:
  Name:    [YOUR FULL NAME]
  Role:    [ROLE]
  Address: [YOUR ADDRESS]
  Phone:   [YOUR PHONE]

Sincerely,

[YOUR SIGNATURE]
[YOUR PRINTED NAME]
[DATE]$TPL$,
  ARRAY['mortgage', 'property', 'home', 'loan', 'notification']
)
ON CONFLICT (name) DO UPDATE
  SET content = EXCLUDED.content, category = EXCLUDED.category,
      type = EXCLUDED.type, tags = EXCLUDED.tags;


INSERT INTO public.templates (name, category, type, content, tags)
VALUES (
  'HOA Condo Association Death Notification Letter',
  'Property & Home', 'letter',
$TPL$[DATE]

[HOA / CONDO ASSOCIATION NAME]
Board of Directors / Management Office
[ADDRESS]
[CITY, STATE, ZIP]

Re: Death Notification — Homeowner [DECEASED FULL NAME]
Property Address: [PROPERTY ADDRESS]
Unit / Lot: [UNIT OR LOT NUMBER]

Dear Board of Directors:

I am writing to notify the Association of the death of [DECEASED FULL NAME], owner of [PROPERTY ADDRESS], who passed away on [DATE OF DEATH].

I am the [EXECUTOR OF THE ESTATE / HEIR] and am managing the estate during the administration period.

I request that you:

1. Update your records to reflect the change in ownership status.
2. Confirm the current monthly dues amount and payment instructions so that dues can continue to be paid from estate funds during administration.
3. Advise of any special assessments, outstanding balances, or fees currently owed.
4. Provide information about any HOA requirements or restrictions regarding the sale or transfer of the property.

Please direct all future communications to:
  Name:    [YOUR FULL NAME]
  Address: [YOUR ADDRESS]
  Phone:   [YOUR PHONE]
  Email:   [YOUR EMAIL]

Enclosed: Certified copy of death certificate.

Sincerely,

[YOUR SIGNATURE]
[YOUR PRINTED NAME]
[RELATIONSHIP TO DECEASED]
[DATE]$TPL$,
  ARRAY['HOA', 'condo', 'property', 'homeowners association', 'notification']
)
ON CONFLICT (name) DO UPDATE
  SET content = EXCLUDED.content, category = EXCLUDED.category,
      type = EXCLUDED.type, tags = EXCLUDED.tags;


INSERT INTO public.templates (name, category, type, content, tags)
VALUES (
  'Utility Provider Transfer or Cancellation Letter',
  'Property & Home', 'letter',
$TPL$[DATE]

[UTILITY COMPANY NAME]
Customer Service / Account Management
[ADDRESS]
[CITY, STATE, ZIP]

Re: [TRANSFER / CANCELLATION] of Account — Death of Account Holder
Account Holder: [DECEASED FULL NAME]
Account Number: [ACCOUNT NUMBER]
Service Address: [SERVICE ADDRESS]

Dear Customer Service:

I am writing to request [transfer / cancellation] of the above utility account following the death of the account holder, [DECEASED FULL NAME], who passed away on [DATE OF DEATH].

IF TRANSFERRING:
Please transfer this account to the following name effective [DATE]:
  New Account Holder: [NEW NAME]
  Billing Address:    [NEW BILLING ADDRESS]
  Phone:              [NEW PHONE]
  Email:              [NEW EMAIL]

IF CANCELLING:
Please cancel service effective [CANCELLATION DATE] and arrange for a final meter read on that date. Please send the final bill to:
  Name:    [YOUR FULL NAME]
  Address: [YOUR ADDRESS]

Please confirm [transfer / cancellation] in writing and advise of any outstanding balance or refund due.

Enclosed: Certified copy of death certificate.

My contact information:
  Name:    [YOUR FULL NAME]
  Phone:   [YOUR PHONE]
  Email:   [YOUR EMAIL]

Sincerely,

[YOUR SIGNATURE]
[YOUR PRINTED NAME]
[DATE]$TPL$,
  ARRAY['utility', 'services', 'cancellation', 'electricity', 'gas', 'water']
)
ON CONFLICT (name) DO UPDATE
  SET content = EXCLUDED.content, category = EXCLUDED.category,
      type = EXCLUDED.type, tags = EXCLUDED.tags;


-- ──────────────────────────────────────────────────────────────────────────────
-- PERSONAL & MEMBERSHIPS — letters
-- ──────────────────────────────────────────────────────────────────────────────

INSERT INTO public.templates (name, category, type, content, tags)
VALUES (
  'Employer HR Death Notification and Benefits Inquiry',
  'Personal & Memberships', 'letter',
$TPL$[DATE]

[COMPANY NAME]
Human Resources Department
[ADDRESS]
[CITY, STATE, ZIP]

Re: Death Notification — Employee [DECEASED FULL NAME]
Employee ID: [EMPLOYEE ID, if known]
Department: [DEPARTMENT, if known]

Dear Human Resources Team:

I am writing to notify [COMPANY NAME] of the death of [DECEASED FULL NAME], [JOB TITLE], who passed away on [DATE OF DEATH]. [DECEASED FIRST NAME] was [actively employed / most recently employed from DATE to DATE].

I am the [EXECUTOR OF THE ESTATE / SURVIVING SPOUSE / NEXT OF KIN].

I request information and guidance on all of the following, as applicable:

PAYROLL & WAGES
  1. Final paycheck for wages earned through [DATE OF DEATH], including any accrued and unpaid paid time off.
  2. Any outstanding expense reimbursements.

BENEFITS
  3. Group life insurance — carrier name, policy number, and claim process.
  4. Accidental death and dismemberment (AD&D) insurance — if applicable.
  5. COBRA continuation coverage — election notice for surviving dependents.
  6. Flexible Spending Account (FSA) or Health Savings Account (HSA) balance.

RETIREMENT
  7. 401(k) plan — account balance as of [DATE OF DEATH] and beneficiary claim process.
  8. Pension or defined benefit plan — survivor benefit information.
  9. Employee stock purchase plan (ESPP) or unvested equity (RSUs, options) — disposition process.

OTHER
  10. Any other benefits, incentive pay, or compensation that may be owed to the estate.

Please direct responses to:
  Name:    [YOUR FULL NAME]
  Relationship: [RELATIONSHIP]
  Address: [YOUR ADDRESS]
  Phone:   [YOUR PHONE]
  Email:   [YOUR EMAIL]

Enclosed: Certified copy of death certificate.

Sincerely,

[YOUR SIGNATURE]
[YOUR PRINTED NAME]
[DATE]$TPL$,
  ARRAY['employer', 'HR', 'benefits', 'payroll', 'notification']
)
ON CONFLICT (name) DO UPDATE
  SET content = EXCLUDED.content, category = EXCLUDED.category,
      type = EXCLUDED.type, tags = EXCLUDED.tags;


INSERT INTO public.templates (name, category, type, content, tags)
VALUES (
  'Subscription Service Cancellation Letter',
  'Personal & Memberships', 'letter',
$TPL$[DATE]

[SERVICE / COMPANY NAME]
Customer Support / Account Services
[EMAIL OR MAILING ADDRESS]

Re: Account Cancellation — Death of Account Holder
Account Email: [DECEASED'S EMAIL ADDRESS]
Account Name:  [DECEASED FULL NAME]

Dear Customer Support:

I am writing to request cancellation of the [SERVICE NAME] account belonging to [DECEASED FULL NAME], who passed away on [DATE OF DEATH].

I am the [EXECUTOR OF THE ESTATE / NEXT OF KIN / FAMILY MEMBER] managing the estate.

Please:

1. Cancel the account and all associated subscriptions effective immediately.
2. Stop all future billing to the payment method on file.
3. Issue a refund for any unused prepaid subscription period to the original payment method [or the estate, if the card has been cancelled].
4. Confirm cancellation in writing to this email address: [YOUR EMAIL].

If you require additional documentation, please let me know and I will provide a copy of the death certificate.

Thank you for handling this promptly.

Sincerely,

[YOUR FULL NAME]
[YOUR RELATIONSHIP TO DECEASED]
[YOUR EMAIL]
[YOUR PHONE]
[DATE]$TPL$,
  ARRAY['subscription', 'membership', 'cancellation', 'services']
)
ON CONFLICT (name) DO UPDATE
  SET content = EXCLUDED.content, category = EXCLUDED.category,
      type = EXCLUDED.type, tags = EXCLUDED.tags;


INSERT INTO public.templates (name, category, type, content, tags)
VALUES (
  'Facebook Meta Account Memorialization or Removal Request',
  'Digital Estate', 'letter',
$TPL$[DATE]

Meta Platforms, Inc.
Attn: Special Request Team
1 Meta Way
Menlo Park, CA 94025

Re: [MEMORIALIZATION / REMOVAL] Request — Deceased User Account
Platform: [FACEBOOK / INSTAGRAM]
Account Name: [DECEASED'S DISPLAY NAME]
Profile URL: [PROFILE URL, if known]
Account Email: [DECEASED'S EMAIL, if known]

Dear Meta Support Team:

I am writing to request [memorialization / permanent removal] of the [Facebook / Instagram] account belonging to [DECEASED FULL NAME], who passed away on [DATE OF DEATH].

I am the [IMMEDIATE FAMILY MEMBER / EXECUTOR OF THE ESTATE] of the deceased.

My request: Please [memorialize this account, preserving it as a place of remembrance for friends and family / permanently remove this account and all associated data from your platform].

My information:
  Name:         [YOUR FULL NAME]
  Relationship: [RELATIONSHIP TO DECEASED]
  Email:        [YOUR EMAIL]
  Phone:        [YOUR PHONE]

Enclosed: Copy of death certificate, and a copy of the document establishing my relationship to the deceased.

Please confirm receipt of this request and provide an estimated timeline for completion.

Sincerely,

[YOUR SIGNATURE]
[YOUR PRINTED NAME]
[DATE]$TPL$,
  ARRAY['social media', 'Facebook', 'Instagram', 'digital', 'account']
)
ON CONFLICT (name) DO UPDATE
  SET content = EXCLUDED.content, category = EXCLUDED.category,
      type = EXCLUDED.type, tags = EXCLUDED.tags;


INSERT INTO public.templates (name, category, type, content, tags)
VALUES (
  'Cell Phone Carrier Notification Letter',
  'Personal & Memberships', 'letter',
$TPL$[DATE]

[CARRIER NAME]
Customer Service — Estate / Bereavement Department
[CARRIER ADDRESS]
[CITY, STATE, ZIP]

Re: Account [CANCELLATION / NUMBER TRANSFER REQUEST]
Account Holder: [DECEASED FULL NAME]
Account Number: [ACCOUNT NUMBER]
Phone Number(s): [PHONE NUMBER(S)]

Dear Customer Service:

I am writing regarding the wireless account of [DECEASED FULL NAME], who passed away on [DATE OF DEATH]. I am the [executor of the estate / spouse / authorized representative].

SELECT ONE — DELETE THE OTHER:

OPTION A — CANCELLATION:
Please cancel all lines associated with this account, effective [DATE]. I request that you waive all early termination fees and any remaining device payment plan balances as a bereavement accommodation — a certified death certificate is enclosed. Please issue a final billing statement and confirm cancellation in writing.

OPTION B — NUMBER TRANSFER:
I would like to transfer the phone number [PHONE NUMBER] to a new account in my name before cancelling the remaining account. My information for the new account:
  Name:    [YOUR FULL NAME]
  Address: [YOUR BILLING ADDRESS]
  SSN (last 4): [XXXX]
Please contact me to complete the port request and advise on any required steps.

Please note: No family member has assumed personal liability for device payment plan balances — these are obligations of the estate. Any early termination fees should be waived per your standard bereavement policy.

My contact information:
  Name:    [YOUR FULL NAME]
  Relationship: [RELATIONSHIP]
  Phone:   [YOUR PHONE]
  Email:   [YOUR EMAIL]

Enclosed: Certified copy of death certificate.

Sincerely,

[YOUR SIGNATURE]
[YOUR PRINTED NAME]
[DATE]$TPL$,
  ARRAY['cell phone', 'wireless', 'carrier', 'cancellation', 'services']
)
ON CONFLICT (name) DO UPDATE
  SET content = EXCLUDED.content, category = EXCLUDED.category,
      type = EXCLUDED.type, tags = EXCLUDED.tags;


INSERT INTO public.templates (name, category, type, content, tags)
VALUES (
  'Loyalty Program Airline Miles Points Transfer Request',
  'Personal & Memberships', 'letter',
$TPL$[DATE]

[LOYALTY PROGRAM NAME]
Customer Service — Estate / Bereavement Department
[MAILING ADDRESS OR EMAIL]

Re: Estate Claim — Loyalty Account of Deceased Member
Account Holder: [DECEASED FULL NAME]
Member Number / Account ID: [ACCOUNT NUMBER, if known]
Approximate Point / Mile Balance: [BALANCE, if known]

Dear [PROGRAM NAME] Customer Service Team:

I am writing to notify you of the death of [DECEASED FULL NAME], who passed away on [DATE OF DEATH], and to request information about the status and disposition of their loyalty account.

I am the executor of the Estate of [DECEASED FULL NAME], appointed by [COURT NAME], [COUNTY], [STATE] on [DATE OF APPOINTMENT].

I am requesting the following:

  1. Confirmation of the current account balance as of the date of death;
  2. Information about your policy for transferring or redeeming points or miles belonging to a deceased member;
  3. The steps required to either transfer the balance to [BENEFICIARY NAME / the estate] or redeem the balance on behalf of the estate;
  4. Any forms or documentation required to process this request.

My contact information:
  Name:         [YOUR FULL NAME]
  Relationship: Executor, Estate of [DECEASED FULL NAME]
  Address:      [YOUR ADDRESS]
  Phone:        [YOUR PHONE]
  Email:        [YOUR EMAIL]

Enclosed: Certified copy of death certificate and Letters Testamentary.

Please confirm receipt of this request and advise on next steps at your earliest convenience.

Sincerely,

[YOUR SIGNATURE]
[YOUR PRINTED NAME]
Executor, Estate of [DECEASED FULL NAME]
[DATE]$TPL$,
  ARRAY['airline miles', 'loyalty program', 'rewards', 'personal']
)
ON CONFLICT (name) DO UPDATE
  SET content = EXCLUDED.content, category = EXCLUDED.category,
      type = EXCLUDED.type, tags = EXCLUDED.tags;


-- ──────────────────────────────────────────────────────────────────────────────
-- LEGAL & PROBATE — letters
-- ──────────────────────────────────────────────────────────────────────────────

INSERT INTO public.templates (name, category, type, content, tags)
VALUES (
  'Beneficiary Notification Letter',
  'Legal & Probate', 'letter',
$TPL$[DATE]

[BENEFICIARY FULL NAME]
[BENEFICIARY ADDRESS]
[CITY, STATE, ZIP]

Re: Notice of Estate Administration — Estate of [DECEASED FULL NAME]

Dear [BENEFICIARY FIRST NAME]:

I am writing to notify you of the death of [DECEASED FULL NAME], who passed away on [DATE OF DEATH] in [CITY, STATE].

I, [EXECUTOR FULL NAME], have been named as Executor of the Estate of [DECEASED FULL NAME] pursuant to [his/her/their] Last Will and Testament dated [WILL DATE]. Letters Testamentary were issued to me by [COURT NAME], [COUNTY], [STATE] on [DATE OF LETTERS TESTAMENTARY].

The Will has been filed with [COURT NAME] in [COUNTY], [STATE], where it is available for public inspection during regular court hours.

You are receiving this notice because you are [named as a beneficiary in the Will / a legal heir of the deceased].

The estate is currently in the process of administration, which includes:
  • Inventorying all estate assets
  • Settling all outstanding debts, taxes, and expenses
  • Distributing the remaining assets in accordance with the Will

I will keep you informed of the progress of the estate. Please understand that distributions cannot be made until all debts and obligations of the estate are fully resolved.

You have the right to contest the Will within the time period allowed by [STATE] law. If you have concerns, please consult an attorney promptly, as this period is strictly limited.

For questions, please contact me at:
  Name:    [EXECUTOR FULL NAME]
  Address: [YOUR ADDRESS]
  Phone:   [YOUR PHONE]
  Email:   [YOUR EMAIL]

Sincerely,

[EXECUTOR SIGNATURE]

[EXECUTOR PRINTED NAME], Executor
Estate of [DECEASED FULL NAME]
[DATE]$TPL$,
  ARRAY['beneficiary', 'probate', 'legal', 'estate', 'notification']
)
ON CONFLICT (name) DO UPDATE
  SET content = EXCLUDED.content, category = EXCLUDED.category,
      type = EXCLUDED.type, tags = EXCLUDED.tags;


INSERT INTO public.templates (name, category, type, content, tags)
VALUES (
  'Creditor Notification Letter',
  'Legal & Probate', 'letter',
$TPL$[DATE]

[CREDITOR NAME]
[CREDITOR ADDRESS / BILLING DEPARTMENT]
[CITY, STATE, ZIP]

Re: Notice of Death — Account Holder [DECEASED FULL NAME]
Account Number: [ACCOUNT NUMBER]

Dear Account Services:

I am writing to notify you of the death of [DECEASED FULL NAME], who passed away on [DATE OF DEATH].

I am the [EXECUTOR OF THE ESTATE / LEGAL REPRESENTATIVE] of the deceased.

The estate of [DECEASED FULL NAME] is currently under administration. I request that you:

1. Note the death in your records and direct all future correspondence to me at the address below.
2. Provide a current account statement showing the balance as of [DATE OF DEATH] and any interest or charges that have accrued since.
3. Advise me of the process for filing a creditor claim against the estate, if applicable.
4. Cease collection activities directed at family members or other persons who are not personally liable for this debt.

Outstanding individual debts are obligations of the estate and will be addressed through the estate administration process in accordance with [STATE] law. I will contact you once the estate is able to process creditor claims.

My contact information:
  Name:    [YOUR FULL NAME]
  Role:    [EXECUTOR / REPRESENTATIVE]
  Address: [YOUR ADDRESS]
  Phone:   [YOUR PHONE]
  Email:   [YOUR EMAIL]

Enclosed: Certified copy of death certificate.

Sincerely,

[YOUR SIGNATURE]
[YOUR PRINTED NAME]
[DATE]$TPL$,
  ARRAY['creditor', 'debt', 'legal', 'probate', 'notification']
)
ON CONFLICT (name) DO UPDATE
  SET content = EXCLUDED.content, category = EXCLUDED.category,
      type = EXCLUDED.type, tags = EXCLUDED.tags;


INSERT INTO public.templates (name, category, type, content, tags)
VALUES (
  'Professional License Cancellation Letter',
  'Legal & Probate', 'letter',
$TPL$[DATE]

[LICENSING BOARD / PROFESSIONAL ASSOCIATION NAME]
[ADDRESS]
[CITY, STATE, ZIP]

Re: Notice of Death — Licensed Professional [DECEASED FULL NAME]
License Number: [LICENSE NUMBER]
License Type: [TYPE OF LICENSE / CREDENTIAL]

Dear [LICENSING AUTHORITY]:

I am writing to inform [ORGANIZATION NAME] of the death of [DECEASED FULL NAME], a [PROFESSION] licensed by your board, who passed away on [DATE OF DEATH]. I am the [executor of the estate / spouse / authorized representative].

I respectfully request the following actions:

1. Record the death and formally retire License Number [LICENSE NUMBER], effective [DATE OF DEATH].
2. Confirm that the license has been closed to prevent unauthorized use.
3. Advise whether any formal resignation, notice, or filing is required under [STATE] law or your organization's rules.
4. Provide information about any refund of prepaid membership dues or licensing fees for the period following [DATE OF DEATH].
5. Advise whether your organization issues any memorial recognition or acknowledgment for deceased members.

A certified copy of the death certificate is enclosed for your records.

Please direct all correspondence to me at the address below. Thank you for your assistance.

Sincerely,

[YOUR SIGNATURE]

[YOUR PRINTED NAME]
[YOUR RELATIONSHIP / ROLE]
[YOUR ADDRESS]
[CITY, STATE, ZIP]
[PHONE / EMAIL]

Enclosed: Certified copy of death certificate.
Sent via: Certified Mail, Return Receipt Requested.$TPL$,
  ARRAY['professional license', 'license', 'notification', 'cancellation']
)
ON CONFLICT (name) DO UPDATE
  SET content = EXCLUDED.content, category = EXCLUDED.category,
      type = EXCLUDED.type, tags = EXCLUDED.tags;


INSERT INTO public.templates (name, category, type, content, tags)
VALUES (
  'Heir Receipt and Release',
  'Legal & Probate', 'letter',
$TPL$RECEIPT AND RELEASE OF EXECUTOR

Estate of [DECEASED FULL NAME], Deceased

Date of Death: [DATE OF DEATH]
State of Administration: [STATE]

I, [HEIR FULL NAME], residing at [HEIR ADDRESS], hereby acknowledge and agree as follows:

1. RECEIPT OF DISTRIBUTION

I have received from [EXECUTOR FULL NAME], Executor of the Estate of [DECEASED FULL NAME], the following distribution in full satisfaction of my interest in the estate:

  [DESCRIBE DISTRIBUTION IN DETAIL]
  Examples:
    • Cash payment of $[AMOUNT], received by wire transfer / check on [DATE]
    • Transfer of [PROPERTY DESCRIPTION] as described in the Will
    • Transfer of [SPECIFIC PERSONAL PROPERTY ITEMS]

2. ACKNOWLEDGMENT

I acknowledge that this distribution represents my full and complete share of the estate as provided under the Will of [DECEASED FULL NAME] dated [WILL DATE] / under the laws of intestacy of [STATE].

3. RELEASE

In consideration of the above distribution, I hereby release and discharge [EXECUTOR FULL NAME], as Executor of the Estate of [DECEASED FULL NAME], and the estate itself, from any and all claims, demands, or causes of action that I may have or claim to have arising from the administration of the estate, to the extent permitted by law.

4. AGREEMENT

I agree that if it is subsequently determined that any additional assets exist, or that any distributions were made in error, I will cooperate in good faith to rectify the matter.

Signed:

______________________________
[HEIR FULL NAME]

Date: _________________________

Address: [HEIR ADDRESS]

[NOTARY BLOCK — RECOMMENDED]

State of ________________, County of ________________

Subscribed and sworn to before me this _____ day of __________, 20____.

Notary Public: ___________________________
My commission expires: ___________________

————————————————————————————
FOR EXECUTOR USE ONLY:

Distribution made by: [EXECUTOR FULL NAME]
Date of distribution: [DATE]
Witnessed by: [WITNESS NAME, if any]$TPL$,
  ARRAY['heir', 'distribution', 'release', 'executor', 'legal']
)
ON CONFLICT (name) DO UPDATE
  SET content = EXCLUDED.content, category = EXCLUDED.category,
      type = EXCLUDED.type, tags = EXCLUDED.tags;


-- ──────────────────────────────────────────────────────────────────────────────
-- ADDITIONAL TASK-LINKED TEMPLATES (not in template_library.html)
-- Used by tasks.template column — must exist for the portal modal to work
-- ──────────────────────────────────────────────────────────────────────────────

INSERT INTO public.templates (name, category, type, content, tags)
VALUES (
  'Probate Petition Cover Letter',
  'Legal & Probate', 'letter',
$TPL$[DATE]

[PROBATE COURT NAME]
[COURT ADDRESS]
[CITY, STATE, ZIP]

Re: Petition to Open Probate — Estate of [DECEASED FULL NAME]
Date of Death: [DATE OF DEATH]
County of Filing: [COUNTY], [STATE]

Dear Clerk of the [PROBATE COURT NAME]:

I am submitting this petition and the enclosed documents to formally open probate proceedings for the Estate of [DECEASED FULL NAME], who passed away on [DATE OF DEATH] in [CITY, STATE].

[DECEASED FULL NAME] died [testate (with a Will) / intestate (without a Will)]. The original Last Will and Testament, dated [WILL DATE], is enclosed herewith. The estimated gross value of the probate estate is approximately $[ESTATE VALUE].

I, [YOUR FULL NAME], am named [Executor / Administrator] in the Will and respectfully request that this Court:
  1. Accept the Will for probate and admit it as the valid Last Will and Testament;
  2. Formally appoint me as Executor of the estate;
  3. Issue Letters Testamentary authorizing me to act on behalf of the estate.

Enclosed for your review:
  [ ] Original Last Will and Testament
  [ ] Certified Death Certificate (2 copies)
  [ ] Petition for Probate (Form [FORM NUMBER])
  [ ] Filing fee of $[FILING FEE]
  [ ] List of heirs and beneficiaries with current addresses

I respectfully request that this matter be scheduled at the Court's earliest convenience. Please contact me with any questions or requests for additional documentation.

Respectfully submitted,

[YOUR SIGNATURE]

[YOUR FULL NAME], Petitioner
[YOUR ADDRESS]
[YOUR PHONE]
[YOUR EMAIL]

Enclosures: As listed above$TPL$,
  ARRAY['probate', 'court', 'petition', 'legal', 'executor']
)
ON CONFLICT (name) DO UPDATE
  SET content = EXCLUDED.content, category = EXCLUDED.category,
      type = EXCLUDED.type, tags = EXCLUDED.tags;


INSERT INTO public.templates (name, category, type, content, tags)
VALUES (
  'Vehicle Lease Termination Letter',
  'Property & Home', 'letter',
$TPL$[DATE]

[LEASE COMPANY NAME]
[CUSTOMER SERVICE / ESTATE DEPARTMENT]
[ADDRESS]
[CITY, STATE, ZIP]

Re: Early Lease Termination Due to Death of Lessee
Account Holder: [DECEASED FULL NAME]
Lease Account Number: [ACCOUNT NUMBER]
Vehicle: [YEAR] [MAKE] [MODEL], VIN [VIN NUMBER]

Dear [LEASE COMPANY NAME]:

I am writing to request early termination of the above vehicle lease agreement due to the death of the lessee, [DECEASED FULL NAME], who passed away on [DATE OF DEATH].

I am the [EXECUTOR OF THE ESTATE / NEXT OF KIN] of the deceased.

I understand that early termination may result in a fee or remaining balance obligation under the lease terms. Many lease agreements contain provisions allowing early termination without penalty upon the death of the lessee — please advise whether this provision applies here.

Please provide:
  1. The payoff amount or remaining obligations to terminate the lease;
  2. Any early termination fees applicable under the agreement;
  3. Instructions for returning the vehicle in good condition;
  4. Confirmation of the final settlement amount owed by the estate.

The vehicle is currently located at [VEHICLE CURRENT LOCATION] and is available for return at your convenience.

Enclosed: Certified copy of death certificate.

My contact information:
  Name:    [YOUR FULL NAME]
  Role:    [EXECUTOR / NEXT OF KIN]
  Address: [YOUR ADDRESS]
  Phone:   [YOUR PHONE]
  Email:   [YOUR EMAIL]

Sincerely,

[YOUR SIGNATURE]
[YOUR PRINTED NAME]
[DATE]$TPL$,
  ARRAY['vehicle', 'lease', 'car', 'property', 'termination']
)
ON CONFLICT (name) DO UPDATE
  SET content = EXCLUDED.content, category = EXCLUDED.category,
      type = EXCLUDED.type, tags = EXCLUDED.tags;


INSERT INTO public.templates (name, category, type, content, tags)
VALUES (
  'Health Insurance Cancellation Letter',
  'Personal & Memberships', 'letter',
$TPL$[DATE]

[INSURANCE COMPANY NAME]
Member Services / Policy Administration
[ADDRESS]
[CITY, STATE, ZIP]

Re: Policy Cancellation Due to Death of Insured — [DECEASED FULL NAME]
Policy Number: [POLICY NUMBER]
Group Number: [GROUP NUMBER, if applicable]
Date of Death: [DATE OF DEATH]

Dear Member Services:

I am writing to request cancellation of the health insurance policy held by [DECEASED FULL NAME], who passed away on [DATE OF DEATH].

I am the [EXECUTOR OF THE ESTATE / SURVIVING SPOUSE / NEXT OF KIN] of the deceased.

Please cancel Policy No. [POLICY NUMBER] effective [DATE OF DEATH] and:

  1. Confirm in writing that the policy has been cancelled and all future premium drafts have been stopped;
  2. Provide a final premium statement and confirm any refund due to the estate;
  3. Continue processing any outstanding claims for dates of service prior to [DATE OF DEATH] and remit payment to the estate;
  4. If dependents are covered under this policy, advise regarding COBRA continuation coverage or conversion options available to them — the COBRA election deadline is 60 days from the qualifying event.

Please issue any premium refund by check to "Estate of [DECEASED FULL NAME]" at the address below.

Enclosed: Certified copy of death certificate.

My contact information:
  Name:    [YOUR FULL NAME]
  Role:    [EXECUTOR / REPRESENTATIVE]
  Address: [YOUR ADDRESS]
  Phone:   [YOUR PHONE]
  Email:   [YOUR EMAIL]

Sincerely,

[YOUR SIGNATURE]
[YOUR PRINTED NAME]
[DATE]$TPL$,
  ARRAY['health insurance', 'insurance', 'cancellation', 'policy']
)
ON CONFLICT (name) DO UPDATE
  SET content = EXCLUDED.content, category = EXCLUDED.category,
      type = EXCLUDED.type, tags = EXCLUDED.tags;


-- ──────────────────────────────────────────────────────────────────────────────
-- GUIDES (7 — from template_library.html)
-- ──────────────────────────────────────────────────────────────────────────────

INSERT INTO public.templates (name, category, type, content, tags)
VALUES (
  'IRS Form 1310 — Claiming a Refund for a Deceased Taxpayer',
  'Government & Benefits', 'guide',
$TPL$IRS FORM 1310 — CLAIMING A REFUND FOR A DECEASED TAXPAYER
Step-by-Step Guide

WHEN YOU NEED THIS FORM
1. Use Form 1310 when the deceased is owed a federal tax refund and you are NOT the surviving spouse filing a joint return.
2. A surviving spouse filing a joint return does NOT need Form 1310 — sign the return as usual.
3. An executor or administrator appointed by a court should check Box B on the form.
4. A person other than a spouse or court-appointed representative should check Box C.

HOW TO COMPLETE THE FORM
1. Line 1 — Enter the deceased's name, SSN, and date of death exactly as shown on the final 1040.
2. Line 2 — Check the appropriate box: Box A (surviving spouse), Box B (court-appointed executor), or Box C (other claimant).
3. Box C claimants must also check "Yes" or "No" to the probate question and attach a copy of the death certificate.
4. Sign and date the form as the claimant — not as the deceased.
5. Attach Form 1310 to the front of the final Form 1040 before mailing.

WHERE TO FILE
1. Mail the completed Form 1040 with Form 1310 attached to the IRS address shown in the 1040 instructions for the deceased's state.
2. Do not e-file if submitting Form 1310 — the IRS requires a paper return in most cases involving deceased taxpayers.
3. Processing time: 6–12 weeks for paper returns. The refund check will be made out to the estate or the claimant as you indicate on the form.

TIP: If the deceased used a tax professional in prior years, contact that professional — they will have prior returns on file and can prepare the final return efficiently.

WARNING: Do not cash a refund check made out to the deceased. It must be deposited into the estate bank account or reissued — contact the IRS if this happens.$TPL$,
  ARRAY['IRS', 'tax', 'refund', 'Form 1310', 'guide']
)
ON CONFLICT (name) DO UPDATE
  SET content = EXCLUDED.content, category = EXCLUDED.category,
      type = EXCLUDED.type, tags = EXCLUDED.tags;


INSERT INTO public.templates (name, category, type, content, tags)
VALUES (
  'IRS EIN Application — Estate Tax ID Number',
  'Government & Benefits', 'guide',
$TPL$IRS EIN APPLICATION — ESTATE TAX ID NUMBER
Step-by-Step Guide for Executors

BEFORE YOU BEGIN
1. You need an EIN if: the estate goes through probate, earns any income after death, or requires a separate estate bank account.
2. Only the executor or court-appointed administrator can apply — you'll need your own SSN for the application.
3. The online application is free and takes about 5 minutes. The EIN is issued immediately.

STEP-BY-STEP ONLINE APPLICATION
1. Go to irs.gov and search "EIN online application" or navigate directly to the EIN Assistant.
2. Select "Estate" as the entity type when prompted.
3. Enter the deceased's full legal name and SSN, their date of death, and the estate's legal name: "Estate of [DECEASED FULL NAME]".
4. Enter your (the executor's) name, SSN, and address as the responsible party.
5. Select the reason: choose "Banking purpose" or "Estate administration" — do NOT select "Started a new business."
6. Review and submit. The EIN appears immediately on screen — print or screenshot this page.
7. The IRS also mails a confirmation letter (CP 575) within 4 weeks. Keep this letter permanently.

USING THE EIN
1. Use the EIN (not the deceased's SSN) for: opening the estate bank account, filing Form 1041, and any financial transactions made on behalf of the estate after death.
2. The estate's tax year can be a fiscal year — consult a CPA for the most tax-efficient choice.

TIP: The EIN application cannot be submitted more than once per day for the same estate. If the session times out, wait until the next day to try again.$TPL$,
  ARRAY['IRS', 'EIN', 'tax', 'estate', 'executor', 'guide']
)
ON CONFLICT (name) DO UPDATE
  SET content = EXCLUDED.content, category = EXCLUDED.category,
      type = EXCLUDED.type, tags = EXCLUDED.tags;


INSERT INTO public.templates (name, category, type, content, tags)
VALUES (
  'IRS Form 1041 — Estate Income Tax Return Guide',
  'Government & Benefits', 'guide',
$TPL$IRS FORM 1041 — ESTATE INCOME TAX RETURN
Guide for Executors

WHAT FORM 1041 IS — AND HOW IT DIFFERS FROM THE FINAL 1040
1. Form 1040 is the deceased's final personal income tax return, covering income earned from January 1 of the year of death through the date of death. This is filed once.
2. Form 1041 is a separate return for the estate itself. After death, the estate becomes its own legal and tax entity. If that entity earns income — interest, dividends, rental income, proceeds from asset sales — the estate must report and potentially pay tax on that income.
3. The two returns cover different time periods and different income. Both may be required. A CPA handles both.

WHEN FORM 1041 IS REQUIRED
1. A Form 1041 must be filed if the estate has gross income of $600 or more during the tax year.
2. Common sources of estate income: interest in the estate bank account, dividends paid after the date of death, rental income from property still owned by the estate, capital gains from selling estate assets, and business income.
3. If the estate earns less than $600 total, no 1041 is required — confirm this with a CPA.

KEY DEADLINES AND TAX YEAR
1. Unlike individuals, an estate can use either a calendar year or a fiscal year. This choice is made on the first Form 1041 filed and cannot be changed.
2. A fiscal year can be advantageous for tax planning — consult a CPA before the first return is due.
3. The 1041 is due on the 15th day of the fourth month after the end of the estate's tax year.
4. Extensions are available — Form 7004 extends the deadline by five months.
5. The estate's tax year begins the day after the date of death.

WHAT THE EXECUTOR NEEDS TO PREPARE
1. The estate's EIN — required to file. See the IRS EIN Application guide.
2. All statements showing income earned by the estate after the date of death.
3. Records of estate administration expenses that may be deductible: executor fees, attorney fees, CPA fees, court costs.
4. If the estate sold any assets, you will need the date-of-death value to calculate capital gains.

K-1s — WHAT THEY ARE AND WHY BENEFICIARIES NEED THEM
1. If the estate distributes income to beneficiaries during the year, those distributions are reported on a Schedule K-1, issued to each beneficiary.
2. The K-1 tells each beneficiary what portion of estate income they received and must report on their own personal tax return.
3. Beneficiaries cannot file their own taxes accurately until they receive their K-1.

WHY A CPA IS REQUIRED FOR THIS RETURN
1. Form 1041 is significantly more complex than a standard personal return.
2. Errors can result in penalties, overpayment of tax, or incorrect K-1s.
3. A CPA experienced in estate taxation will also advise on timing of distributions and choice of tax year.
4. Engage a CPA as early in the administration as possible.

TIP: If the estate earns any income at all after the date of death — even a small amount of bank interest — consult a CPA immediately. The decision about the estate's tax year must be made before the first return is due and cannot be undone.$TPL$,
  ARRAY['IRS', 'Form 1041', 'tax', 'estate income', 'executor', 'guide']
)
ON CONFLICT (name) DO UPDATE
  SET content = EXCLUDED.content, category = EXCLUDED.category,
      type = EXCLUDED.type, tags = EXCLUDED.tags;


INSERT INTO public.templates (name, category, type, content, tags)
VALUES (
  'VitalChek — How to Order Certified Death Certificates',
  'Government & Benefits', 'guide',
$TPL$VITALCHEK — HOW TO ORDER CERTIFIED DEATH CERTIFICATES
Guide for Executors and Family Members

HOW MANY COPIES TO ORDER
1. Simple estate (1 bank, no property, few accounts): order 15 certified copies.
2. Typical estate (2–3 banks, 1 home, retirement accounts, insurance): order 20–25 copies.
3. Complex estate (multiple properties, many accounts, business interests, VA, multi-state): order 30–35 copies.
4. Rule of thumb: each bank requires 1 copy, each insurance policy requires 1 copy, each government agency requires 1 copy, probate court requires 1–2 copies. Add 5 spare copies to whatever total you calculate.
5. Under-ordering is a serious mistake — reorders from some states take 2–4 weeks, stalling insurance claims, bank transfers, and probate filings in the meantime.
6. The cost of an extra copy ($10–$25) is trivial compared to the cost of a delayed estate.

STANDARD VS. EXPEDITED DELIVERY
1. Standard processing: 2–6 weeks depending on state. Acceptable if the death was months ago and there is no urgency.
2. Expedited processing: 3–7 business days. Costs an extra $10–$30 per order. Strongly recommended for all new engagements.
3. In-person at the county vital records office: same-day or next-day in many counties. Best option when speed is critical.
4. Funeral homes can often order on your behalf and have them within a week — ask at the time of arrangement.

ORDERING VIA VITALCHEK (vitalchek.com)
1. Go to vitalchek.com and click "Order Vital Records," then select "Death Certificate."
2. Select the state where the death OCCURRED (not where the deceased lived, if different).
3. Enter: deceased's full legal name, date of birth, date of death, county of death, and your name and relationship.
4. Select the quantity and delivery method. Provide a shipping address — use the executor's address.
5. Payment: credit or debit card. Total = (state fee × number of copies) + VitalChek convenience fee ($10–$20 flat).
6. You may be asked to upload a photo ID and a document proving your relationship to the deceased.
7. Save your order confirmation number. VitalChek's customer service is at 1-800-255-2414.

WHEN CERTIFICATES ARRIVE — WHAT TO DO
1. Count the copies immediately upon arrival and confirm they are certified (raised seal or colored security paper).
2. Store all originals together in a labeled folder in a fireproof location. Do not fold, hole-punch, or write on them.
3. Keep a tracking log: record which institution received which copy, the date sent, and whether it was returned.
4. Some institutions return originals after review; most financial institutions retain them permanently.
5. If you run out: reorder immediately through VitalChek or directly through the state vital records office.

STATE-SPECIFIC NOTES
1. New York City deaths: order through the NYC Office of Vital Records. Same-day service available in person at 125 Worth Street, Manhattan.
2. California: order through CDPH Vital Records or the county registrar. Fee: $21/copy. Expedited available via VitalChek.
3. Texas: order through DSHS or county clerk. Fee: $20/copy. 10–15 business day standard processing.
4. Florida: order through FDOH Bureau of Vital Statistics. Fee: $10 first copy, $4 each additional.
5. Pennsylvania: mail orders take 6–8 weeks. Consider ordering in person at the county courthouse for recent deaths.

TIP: Social media platforms and some subscription services accept a scanned death certificate for account closure. Reserve physical certified copies for banks, insurers, government agencies, and courts — these institutions require originals and rarely make exceptions.

WARNING: Do not write on, fold, or laminate death certificates. Institutions may reject certificates that appear altered. Keep all originals in a secure, fireproof location.$TPL$,
  ARRAY['death certificate', 'VitalChek', 'vital records', 'government', 'guide']
)
ON CONFLICT (name) DO UPDATE
  SET content = EXCLUDED.content, category = EXCLUDED.category,
      type = EXCLUDED.type, tags = EXCLUDED.tags;


INSERT INTO public.templates (name, category, type, content, tags)
VALUES (
  'Inherited IRA and 401k — Beneficiary Claim Guide',
  'Financial Accounts', 'guide',
$TPL$INHERITED IRA & 401(k) — BENEFICIARY CLAIM GUIDE
How to claim inherited retirement accounts without triggering an immediate tax bill.

BEFORE YOU DO ANYTHING — THREE RULES
1. Never take a direct distribution from the account without advice. A lump-sum distribution of a large IRA pushes all of it into ordinary income in a single tax year, often at the highest bracket.
2. Never roll it directly into your own existing IRA without confirming the correct rollover type — doing this wrong can trigger immediate taxation on the full balance.
3. Contact the account custodian (Fidelity, Vanguard, Schwab, etc.) before taking any action and ask specifically for the "estate services" or "inherited account" team.

STEP 1 — CONTACT THE CUSTODIAN
1. Call the brokerage's main number and ask for the estate services or inherited account department — not general customer service.
2. Tell them you are the beneficiary of a deceased account holder and need to initiate a beneficiary claim.
3. They will mail or email a claim packet specific to your situation.
4. Documents typically required: certified death certificate, completed beneficiary claim form, your government-issued photo ID, and your Social Security number.
5. Processing time after submission: typically 2–6 weeks.

OPTIONS FOR SURVIVING SPOUSES
1. Spousal rollover: roll the deceased's IRA into your own IRA. No taxes due at rollover. RMDs are based on your own age. This is the most flexible option and generally the most tax-efficient — recommended in most cases.
2. Inherited IRA: treat the account as an inherited IRA. Allows penalty-free withdrawals before age 59½ if you need income now.
3. Lump sum: take the entire balance as a distribution. The full amount is taxable as ordinary income in the year received. Rarely the best option — consult a financial advisor first.

OPTIONS FOR NON-SPOUSE BENEFICIARIES (SECURE 2.0 ACT, 2022)
1. 10-year rule: most non-spouse beneficiaries must fully distribute the inherited account within 10 years of the owner's death. Annual distributions are NOT required — the account just must be emptied by the end of year 10.
2. Eligible Designated Beneficiaries get a longer window: minor children of the deceased, disabled individuals, chronically ill individuals, and individuals not more than 10 years younger than the deceased.
3. For the 10-year rule, spread withdrawals across 10 years to keep each distribution in a lower tax bracket.

WHEN NO BENEFICIARY WAS NAMED
1. If the beneficiary designation is missing, outdated, or names "the estate," the account typically passes through probate.
2. A probate asset loses the tax-advantaged transfer rules.
3. The executor (with Letters Testamentary) can claim the account on behalf of the estate, but distribution rules are compressed — often requiring full distribution within 5 years.

TIP: The stepped-up cost basis does NOT apply to IRAs and 401(k)s — all distributions are fully taxable as ordinary income regardless of when the assets were purchased.

WARNING: Community property states (AZ, CA, ID, LA, NM, NV, TX, WA, WI): a surviving spouse may have a community property interest in a retirement account even if they are not the named beneficiary. Do not take any action on retirement accounts in these states without consulting an estate attorney.$TPL$,
  ARRAY['IRA', '401k', 'inherited', 'retirement', 'beneficiary', 'guide']
)
ON CONFLICT (name) DO UPDATE
  SET content = EXCLUDED.content, category = EXCLUDED.category,
      type = EXCLUDED.type, tags = EXCLUDED.tags;


INSERT INTO public.templates (name, category, type, content, tags)
VALUES (
  'How to Open Probate — Step-by-Step Process Guide',
  'Legal & Probate', 'guide',
$TPL$HOW TO OPEN PROBATE — STEP-BY-STEP PROCESS GUIDE
Plain-language overview for executors and administrators.

FIRST: DETERMINE WHETHER PROBATE IS EVEN REQUIRED
1. Assets that AVOID probate entirely: joint tenancy assets pass automatically to the surviving owner; assets with named beneficiaries (life insurance, retirement accounts, POD/TOD bank accounts) pass directly; assets held in a living trust pass through the trust.
2. Assets that typically REQUIRE probate: real property owned solely by the deceased, bank accounts in the deceased's name only with no beneficiary designation, personal property above state thresholds.
3. If the entire estate consists of non-probate assets, no court involvement is needed at all.
4. Many states have simplified small-estate procedures that avoid full probate — check your state's threshold (California: $184,500 / Texas: $75,000 / New York: $50,000 / Florida: $75,000).
5. If in doubt: a 30-minute consultation with an estate attorney is the most efficient way to answer this question.

DOCUMENTS YOU WILL NEED TO OPEN PROBATE
1. Original will — not a copy. Courts will not accept photocopies in most states.
2. Certified death certificate — typically 1–2 copies for the initial filing.
3. Petition to Admit Will to Probate and to Appoint Executor — obtained from the county court or your attorney.
4. List of all heirs at law and beneficiaries named in the will — full legal names and current addresses.
5. Filing fee — typically $50–$400 payable to the court by check or money order.

STEP-BY-STEP: OPENING PROBATE
1. Step 1 — File the petition at the correct court. File at the Probate Court in the COUNTY where the deceased was domiciled at death.
2. Step 2 — Pay the filing fee. Get a file-stamped copy of the petition for your records.
3. Step 3 — The court schedules a hearing — typically 2–8 weeks after filing. In some states, an uncontested will can be approved without a hearing.
4. Step 4 — Notify all heirs and beneficiaries of the hearing date. Most states require certified mail with return receipt.
5. Step 5 — Publish a creditor notice in a newspaper of general circulation. Most states require 3–4 consecutive weeks of publication.
6. Step 6 — Attend the hearing. The court admits the will to probate and formally appoints the executor.
7. Step 7 — Receive Letters Testamentary. Order 10–15 certified copies immediately ($5–$20 each). These are your legal authority to act.

AFTER PROBATE IS OPENED — ONGOING OBLIGATIONS
1. File the estate asset inventory with the court (required within 60–90 days in most states).
2. Maintain an estate bank account — all income and expenses of the estate flow through it.
3. Keep detailed records of every financial transaction made on behalf of the estate.
4. At the conclusion, file a final accounting and petition for distribution.

STATE FILING TIMES AND COMPLEXITY
1. California: 18–24 months typical. Attorney fees are statutory (~4% of estate value). Court confirmation required for most real estate sales.
2. Texas: 6–12 months typical with Independent Administration. Muniment of Title available for some simple estates.
3. Florida: 6–12 months typical for formal administration. Summary Administration available for estates under $75,000.
4. New York: 12–18 months typical. NYC Surrogate's Court can be slower. Attorney representation strongly recommended.
5. Illinois, Pennsylvania, Michigan: 9–15 months typical.

TIP: If the deceased had a living trust that was properly funded, the trust assets do not go through probate at all — they are distributed by the trustee according to the trust document. This can save 12–24 months and significant legal fees.

WARNING: Only the named executor can file the probate petition.$TPL$,
  ARRAY['probate', 'court', 'legal', 'executor', 'guide']
)
ON CONFLICT (name) DO UPDATE
  SET content = EXCLUDED.content, category = EXCLUDED.category,
      type = EXCLUDED.type, tags = EXCLUDED.tags;


INSERT INTO public.templates (name, category, type, content, tags)
VALUES (
  'Estate Asset Inventory — How to Compile All Four Categories',
  'Legal & Probate', 'guide',
$TPL$ESTATE ASSET INVENTORY — HOW TO COMPILE ALL FOUR CATEGORIES
A structured approach to documenting every estate asset. Required for probate court, estate taxes, and equitable distribution.

WHY THIS MATTERS — AND THE DATE-OF-DEATH RULE
1. The estate asset inventory is the foundation of probate: the court requires it, the IRS uses it for estate taxes, and heirs need it for equitable distribution.
2. Every value in the inventory must reflect fair market value as of the DATE OF DEATH — not the current date, not the purchase price.
3. For tax purposes, inherited assets receive a "stepped-up cost basis" to the date-of-death value. This eliminates capital gains that accrued during the deceased's lifetime — a significant tax benefit.
4. Begin the inventory immediately. Values as of the date of death can be documented retroactively.

CATEGORY 1 — REAL PROPERTY
1. List every property: address, legal description (from the deed), and ownership type (sole, joint tenancy, tenancy in common, community property).
2. Value: obtain a formal appraisal from a certified residential appraiser for each property. Cost: $300–$600 for a home. Required for probate and estate taxes.
3. Note any mortgages, liens, or encumbrances — the net equity (value minus mortgage) enters the estate.
4. Out-of-state real property requires ancillary probate in that state — flag these for your attorney immediately.

CATEGORY 2 — FINANCIAL ACCOUNTS
1. For each account: institution name, account type, account number (last 4 digits), and balance as of the date of death.
2. Request a "date of death statement" from each institution.
3. For brokerage accounts: record each security holding and its closing price on the date of death.
4. For retirement accounts: record the balance and note the named beneficiary.
5. For life insurance: record the policy number, insurer, death benefit amount, and named beneficiary.
6. Savings bonds: check current value at treasurydirect.gov.

CATEGORY 3 — PERSONAL PROPERTY
1. Personal property includes: vehicles, jewelry, art, furniture, electronics, clothing, tools, sporting equipment, collections, and all household contents.
2. High-value items ($500+): obtain a written appraisal. Required for jewelry, art, antiques, and collectibles.
3. Vehicles: use Kelley Blue Book private party value as of the date of death.
4. Firearms: document carefully. Transfers are subject to federal law. Flag for attorney before any transfer.
5. Photograph everything of significant value — timestamps on photos serve as documentation.

CATEGORY 4 — DIGITAL AND INTANGIBLE ASSETS
1. Cryptocurrency: document type, quantity held, and closing price on the date of death. Note where held.
2. Domain names and websites: document each domain, registrar, and estimated value.
3. Online business accounts (Etsy, Amazon seller, YouTube): document revenue and estimated value.
4. Loyalty points and airline miles: document each program, balance, and estimated cash value.
5. Intellectual property (patents, copyrights, royalties): requires specialized valuation.

DEBTS AND LIABILITIES — THE OTHER SIDE OF THE LEDGER
1. The inventory must also document all debts: mortgages, car loans, credit cards, personal loans, medical bills.
2. Debts are paid from estate assets before any distribution to heirs. Net estate = total assets minus total liabilities.
3. Do not pay debts from personal funds. All payments must flow through the estate bank account.
4. If liabilities exceed assets (insolvent estate): consult an attorney immediately.

TIP: Use a spreadsheet with four tabs — one per category. Include columns for: item description, institution/location, account number (last 4), date-of-death value, source of valuation, and notes.

WARNING: The inventory is a legal document filed with the probate court. Intentional omission of assets is a serious legal violation that can expose the executor to personal liability.$TPL$,
  ARRAY['asset inventory', 'probate', 'estate', 'executor', 'guide']
)
ON CONFLICT (name) DO UPDATE
  SET content = EXCLUDED.content, category = EXCLUDED.category,
      type = EXCLUDED.type, tags = EXCLUDED.tags;
