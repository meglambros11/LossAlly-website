-- ============================================================
-- Loss Ally — Template Library Seed
-- 30 letter templates + 7 form guides
-- Run AFTER supabase-templates-schema.sql
-- Safe to re-run: ON CONFLICT (name) DO NOTHING
-- ============================================================

-- Add unique constraint on name if not already present
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'templates_name_unique'
  ) THEN
    ALTER TABLE public.templates ADD CONSTRAINT templates_name_unique UNIQUE (name);
  END IF;
END $$;

INSERT INTO public.templates (name, category, type, subject_line, content, tags) VALUES

-- ──────────────────────────────────────────────────────────────────────────────
-- GOVERNMENT & BENEFITS — 5 letters
-- ──────────────────────────────────────────────────────────────────────────────

(
  'SSA Death Notification Letter',
  'Government & Benefits',
  'letter',
  'Death Notification — [DECEASED_FULL_NAME], SSN [DECEASED_SSN]',
  '[EXECUTOR_NAME]
[EXECUTOR_ADDRESS]
[DATE]

Social Security Administration
[LOCAL_SSA_OFFICE_ADDRESS]

Re: Death Notification — [DECEASED_FULL_NAME]
Social Security Number: [DECEASED_SSN]

Dear Social Security Administration:

I am writing to formally notify the Social Security Administration of the death of [DECEASED_FULL_NAME], Social Security Number [DECEASED_SSN], who passed away on [DATE_OF_DEATH].

I am the [EXECUTOR_RELATIONSHIP] of [DECEASED_FULL_NAME] and am responsible for administering the estate and notifying the appropriate government agencies.

Please take the following actions:
  1. Flag the deceased''s Social Security account as deceased, effective [DATE_OF_DEATH].
  2. Discontinue all future Social Security benefit payments.
  3. Provide information regarding survivor benefits available to eligible family members.

Please be advised that any Social Security payment deposited after [DATE_OF_DEATH] must be returned. I have notified the deceased''s financial institution accordingly.

Enclosed please find a certified copy of the Death Certificate for your records.

Please confirm receipt of this notification in writing. If you require additional documentation or information, please do not hesitate to contact me.

Sincerely,

[EXECUTOR_NAME]
[EXECUTOR_RELATIONSHIP], Estate of [DECEASED_FULL_NAME]
[EXECUTOR_ADDRESS]
[EXECUTOR_EMAIL]
[EXECUTOR_PHONE]

Enclosure: Certified Death Certificate',
  ARRAY['social security', 'government', 'death notification']
),

(
  'SSA Survivor Benefits Application Cover Letter',
  'Government & Benefits',
  'letter',
  'Survivor Benefits Application — Estate of [DECEASED_FULL_NAME]',
  '[APPLICANT_NAME]
[APPLICANT_ADDRESS]
[DATE]

Social Security Administration
[LOCAL_SSA_OFFICE_ADDRESS]

Re: Application for Survivor Benefits — [DECEASED_FULL_NAME], SSN [DECEASED_SSN]

Dear Social Security Administration:

I am writing to apply for survivor benefits following the death of [DECEASED_FULL_NAME], who passed away on [DATE_OF_DEATH]. My relationship to the deceased is: [APPLICANT_RELATIONSHIP].

I believe I may be eligible for the following benefit(s):
  [ ] Surviving spouse benefit
  [ ] Child benefit (for [CHILD_NAME], date of birth [CHILD_DOB])
  [ ] Lump-sum death payment of $255
  [ ] Dependent parent benefit

Enclosed are the following documents in support of this application:
  - Certified Death Certificate
  - [PROOF_OF_RELATIONSHIP_DOCUMENT] (e.g., marriage certificate, birth certificate)
  - My Social Security card
  - [DECEASED_FULL_NAME]''s Social Security number: [DECEASED_SSN]
  - Most recent W-2 or federal tax return for [DECEASED_FULL_NAME]

I understand that I cannot apply for survivor benefits online and am prepared to complete this process by telephone or in person as required. Please contact me to schedule an appointment or to request any additional documentation.

Sincerely,

[APPLICANT_NAME]
[APPLICANT_ADDRESS]
[APPLICANT_EMAIL]
[APPLICANT_PHONE]

Enclosures: As listed above',
  ARRAY['social security', 'survivor benefits', 'government']
),

(
  'Medicare & Medicaid Notification Letter',
  'Government & Benefits',
  'letter',
  'Notification of Death — [DECEASED_FULL_NAME], Medicare Number [MEDICARE_NUMBER]',
  '[EXECUTOR_NAME]
[EXECUTOR_ADDRESS]
[DATE]

Centers for Medicare & Medicaid Services
7500 Security Boulevard
Baltimore, MD 21244

Re: Notification of Death — [DECEASED_FULL_NAME]
Medicare Beneficiary Identifier: [MEDICARE_NUMBER]

Dear Medicare and Medicaid Services:

I am writing to notify you of the death of [DECEASED_FULL_NAME], Medicare Beneficiary Identifier [MEDICARE_NUMBER], who passed away on [DATE_OF_DEATH].

I am the [EXECUTOR_RELATIONSHIP] of [DECEASED_FULL_NAME] and am responsible for administering the estate.

Please take the following actions:
  1. Terminate Medicare Part A and Part B coverage effective [DATE_OF_DEATH].
  2. If the deceased was enrolled in a Medicare Advantage (Part C) or Medicare Part D plan, please notify the applicable private plan administrator.
  3. Terminate any Medigap (Medicare Supplement) coverage.

Please note: Any Medicare payments made for services rendered after [DATE_OF_DEATH] must be refunded. Please notify me of any such payments.

Regarding Medicaid: If [DECEASED_FULL_NAME] received Medicaid benefits, please provide information regarding any estate recovery claim your agency intends to pursue. I understand that Medicaid estate recovery may apply and I will ensure that any valid claims are addressed before distribution of estate assets.

Enclosed please find a certified copy of the Death Certificate.

Please confirm receipt and advise me in writing of any pending claims or recovery amounts. I can be reached at [EXECUTOR_EMAIL] or [EXECUTOR_PHONE].

Sincerely,

[EXECUTOR_NAME]
[EXECUTOR_RELATIONSHIP], Estate of [DECEASED_FULL_NAME]
[EXECUTOR_ADDRESS]
[EXECUTOR_EMAIL]
[EXECUTOR_PHONE]

Enclosure: Certified Death Certificate',
  ARRAY['medicare', 'medicaid', 'government', 'health insurance']
),

(
  'VA Survivor Benefits Letter',
  'Government & Benefits',
  'letter',
  'Notification of Veteran''s Death & Survivor Benefits Inquiry — [DECEASED_FULL_NAME]',
  '[APPLICANT_NAME]
[APPLICANT_ADDRESS]
[DATE]

Department of Veterans Affairs
[LOCAL_VA_REGIONAL_OFFICE_ADDRESS]

Re: Notification of Veteran''s Death and Inquiry Regarding Survivor Benefits
Veteran: [DECEASED_FULL_NAME]
VA File Number / SSN: [VA_FILE_NUMBER]

Dear Department of Veterans Affairs:

I am writing to notify the Department of Veterans Affairs of the death of [DECEASED_FULL_NAME], a United States Veteran, who passed away on [DATE_OF_DEATH]. My relationship to the deceased is: [APPLICANT_RELATIONSHIP].

I am writing to inquire about and initiate claims for applicable survivor benefits, which may include:
  - Dependency and Indemnity Compensation (DIC) — VA Form 21P-534EZ
  - Survivor''s Pension
  - Burial Allowance — VA Form 21P-530
  - Government Headstone or Marker — VA Form 40-1330

Enclosed are the following documents:
  - Certified Death Certificate
  - DD-214 (Certificate of Release or Discharge from Active Duty)
  - [PROOF_OF_RELATIONSHIP_DOCUMENT] (e.g., marriage certificate, birth certificate)

Please advise me on the specific forms required for each applicable benefit and the supporting documentation needed. I am prepared to cooperate fully with your office to ensure timely processing.

Please confirm receipt of this letter and contact me to discuss next steps.

Sincerely,

[APPLICANT_NAME]
[APPLICANT_RELATIONSHIP] of [DECEASED_FULL_NAME]
[APPLICANT_ADDRESS]
[APPLICANT_EMAIL]
[APPLICANT_PHONE]

Enclosures: As listed above',
  ARRAY['veterans affairs', 'VA', 'survivor benefits', 'government']
),

(
  'VA Burial Benefits Application Letter',
  'Government & Benefits',
  'letter',
  'Application for Burial Allowance — [DECEASED_FULL_NAME], Veteran',
  '[APPLICANT_NAME]
[APPLICANT_ADDRESS]
[DATE]

Department of Veterans Affairs
[LOCAL_VA_REGIONAL_OFFICE_ADDRESS]

Re: Application for Burial Allowance — VA Form 21P-530
Veteran: [DECEASED_FULL_NAME]
VA File Number / SSN: [VA_FILE_NUMBER]

Dear Department of Veterans Affairs:

I am submitting this letter in support of a claim for burial allowance following the death of [DECEASED_FULL_NAME], a United States Veteran who served in the [BRANCH_OF_SERVICE] and was discharged on [DISCHARGE_DATE].

[DECEASED_FULL_NAME] passed away on [DATE_OF_DEATH] in [CITY_OF_DEATH], [STATE_OF_DEATH]. The cause of death was [CAUSE_OF_DEATH].

The burial was conducted on [DATE_OF_BURIAL] at [BURIAL_LOCATION]. The total burial expenses were $[BURIAL_COST].

I am the [CLAIMANT_RELATIONSHIP] and am requesting the applicable burial allowance. I have enclosed VA Form 21P-530 (Application for Burial Benefits), completed in full, along with the supporting documentation listed below.

Enclosed documents:
  - VA Form 21P-530 (completed)
  - Certified Death Certificate
  - DD-214 (Certificate of Release or Discharge from Active Duty)
  - Funeral home itemized statement / proof of burial expenses
  - [PROOF_OF_RELATIONSHIP_DOCUMENT]

Please process this claim and advise me of the status. I may be contacted at [APPLICANT_EMAIL] or [APPLICANT_PHONE].

Sincerely,

[APPLICANT_NAME]
[CLAIMANT_RELATIONSHIP] of [DECEASED_FULL_NAME]
[APPLICANT_ADDRESS]
[APPLICANT_EMAIL]
[APPLICANT_PHONE]

Enclosures: As listed above',
  ARRAY['veterans affairs', 'VA', 'burial', 'government']
),

-- ──────────────────────────────────────────────────────────────────────────────
-- LEGAL & PROBATE — 4 letters
-- ──────────────────────────────────────────────────────────────────────────────

(
  'Probate Petition Cover Letter',
  'Legal & Probate',
  'letter',
  'Petition to Open Probate — Estate of [DECEASED_FULL_NAME]',
  '[EXECUTOR_NAME]
[EXECUTOR_ADDRESS]
[DATE]

[PROBATE_COURT_NAME]
[PROBATE_COURT_ADDRESS]

Re: Petition to Open Probate — Estate of [DECEASED_FULL_NAME]
Date of Death: [DATE_OF_DEATH]
County of Filing: [COUNTY_NAME], [ESTATE_STATE]

Dear Clerk of the [PROBATE_COURT_NAME]:

I am submitting this letter and the enclosed documents to formally petition this Court to open probate proceedings for the Estate of [DECEASED_FULL_NAME], who passed away on [DATE_OF_DEATH] in [CITY_OF_DEATH], [ESTATE_STATE].

[DECEASED_FULL_NAME] died [testate / intestate — choose one]. [If testate: The original Last Will and Testament, dated [WILL_DATE], is enclosed herewith.] The estimated gross value of the probate estate is approximately $[ESTATE_VALUE].

I, [EXECUTOR_NAME], am named [Executor / Administrator] in the Will [or: am requesting appointment as Administrator] and respectfully request that this Court:
  1. Accept the Will for probate (if applicable);
  2. Appoint me as [Executor / Administrator] of the estate;
  3. Issue Letters Testamentary (or Letters of Administration).

Enclosed for your review:
  - Original Last Will and Testament (if applicable)
  - Certified Death Certificate
  - Petition for Probate form ([FORM_NUMBER])
  - Filing fee of $[FILING_FEE]
  - [ANY_ADDITIONAL_REQUIRED_FORMS]

I respectfully request that this matter be scheduled at the Court''s earliest convenience. Please contact me with any questions or requests for additional documentation.

Respectfully submitted,

[EXECUTOR_NAME]
Petitioner
[EXECUTOR_ADDRESS]
[EXECUTOR_EMAIL]
[EXECUTOR_PHONE]

Enclosures: As listed above',
  ARRAY['probate', 'court', 'legal', 'estate']
),

(
  'Beneficiary Notification Letter',
  'Legal & Probate',
  'letter',
  'Notice to Beneficiary — Estate of [DECEASED_FULL_NAME]',
  '[EXECUTOR_NAME]
[EXECUTOR_ADDRESS]
[DATE]

[BENEFICIARY_NAME]
[BENEFICIARY_ADDRESS]

Re: Notice to Beneficiary — Estate of [DECEASED_FULL_NAME]

Dear [BENEFICIARY_NAME]:

I am writing to formally notify you that you are named as a beneficiary in the Last Will and Testament of [DECEASED_FULL_NAME], who passed away on [DATE_OF_DEATH].

I, [EXECUTOR_NAME], have been appointed as Executor of the Estate of [DECEASED_FULL_NAME] by the [PROBATE_COURT_NAME], [COUNTY_NAME] County, [ESTATE_STATE]. Letters Testamentary were issued on [LETTERS_DATE].

Under the terms of the Will, you are entitled to receive:
[BEQUEST_DESCRIPTION]

The estate is currently in the process of being administered. This process includes:
  1. Inventorying all estate assets
  2. Notifying creditors and settling all valid debts
  3. Filing required tax returns
  4. Distributing assets to beneficiaries as directed by the Will

Please be aware that distributions to beneficiaries cannot be made until all valid creditor claims and tax obligations of the estate have been resolved. I will keep you informed of the progress and timeline for distribution.

If you have any questions or concerns, please do not hesitate to contact me directly.

Sincerely,

[EXECUTOR_NAME]
Executor, Estate of [DECEASED_FULL_NAME]
[EXECUTOR_ADDRESS]
[EXECUTOR_EMAIL]
[EXECUTOR_PHONE]',
  ARRAY['probate', 'beneficiary', 'legal', 'estate', 'notification']
),

(
  'Letters Testamentary Request Letter',
  'Legal & Probate',
  'letter',
  'Request for Letters Testamentary — Estate of [DECEASED_FULL_NAME]',
  '[EXECUTOR_NAME]
[EXECUTOR_ADDRESS]
[DATE]

[PROBATE_COURT_NAME]
[PROBATE_COURT_ADDRESS]

Re: Request for Letters Testamentary — Estate of [DECEASED_FULL_NAME]
Case Number: [PROBATE_CASE_NUMBER]

Dear Clerk of the Court:

I respectfully request that the Court issue Letters Testamentary for the Estate of [DECEASED_FULL_NAME], in connection with the above-referenced probate case.

[DECEASED_FULL_NAME] passed away on [DATE_OF_DEATH] in [CITY_OF_DEATH], [ESTATE_STATE], leaving a Last Will and Testament dated [WILL_DATE], which was filed with this Court on [WILL_FILING_DATE].

I, [EXECUTOR_NAME], was named Executor in the Will and was appointed by Order of this Court on [APPOINTMENT_DATE]. I require Letters Testamentary to carry out my duties as Executor, including but not limited to:
  - Accessing and closing financial accounts
  - Notifying government agencies and creditors
  - Managing and distributing estate assets
  - Filing required tax returns

I am requesting [NUMBER] certified copies of the Letters Testamentary. Enclosed is payment of the applicable fee of $[FEE_AMOUNT].

Please contact me if additional documentation is required.

Respectfully,

[EXECUTOR_NAME]
Executor, Estate of [DECEASED_FULL_NAME]
[EXECUTOR_ADDRESS]
[EXECUTOR_EMAIL]
[EXECUTOR_PHONE]

Enclosure: Payment of $[FEE_AMOUNT]',
  ARRAY['probate', 'letters testamentary', 'court', 'legal', 'executor']
),

(
  'Small Estate Affidavit Cover Letter',
  'Legal & Probate',
  'letter',
  'Small Estate Affidavit — Estate of [DECEASED_FULL_NAME]',
  '[AFFIANT_NAME]
[AFFIANT_ADDRESS]
[DATE]

[INSTITUTION_NAME]
[INSTITUTION_ADDRESS]

Re: Small Estate Affidavit — Estate of [DECEASED_FULL_NAME]
Date of Death: [DATE_OF_DEATH]

Dear [INSTITUTION_NAME]:

I am writing to request transfer of assets from the estate of [DECEASED_FULL_NAME], who passed away on [DATE_OF_DEATH] in [CITY_OF_DEATH], [ESTATE_STATE].

The total value of [DECEASED_FULL_NAME]''s estate subject to administration does not exceed $[ESTATE_VALUE], which qualifies this estate for small estate procedures under [ESTATE_STATE] law ([STATE_STATUTE_REFERENCE]).

I, [AFFIANT_NAME], am the [AFFIANT_RELATIONSHIP] of [DECEASED_FULL_NAME] and am entitled to the following asset(s) held at your institution:

  Account / Asset: [ACCOUNT_DESCRIPTION]
  Account Number: [ACCOUNT_NUMBER]
  Estimated Value: $[ASSET_VALUE]

Enclosed please find:
  - Completed Small Estate Affidavit (signed and notarized)
  - Certified Death Certificate
  - [MY_IDENTIFICATION_DOCUMENT] (government-issued photo ID)
  - [PROOF_OF_RELATIONSHIP_DOCUMENT] (if applicable)

Please process this request and transfer the above-described asset(s) to me as lawful successor. I affirm that all statements in the enclosed affidavit are true and correct to the best of my knowledge.

Sincerely,

[AFFIANT_NAME]
[AFFIANT_RELATIONSHIP], Estate of [DECEASED_FULL_NAME]
[AFFIANT_ADDRESS]
[AFFIANT_EMAIL]
[AFFIANT_PHONE]

Enclosures: As listed above',
  ARRAY['small estate', 'affidavit', 'legal', 'probate', 'estate']
),

-- ──────────────────────────────────────────────────────────────────────────────
-- FINANCIAL ACCOUNTS — 10 letters
-- ──────────────────────────────────────────────────────────────────────────────

(
  'Financial Institution Notification Letter',
  'Financial Accounts',
  'letter',
  'Notification of Death and Request for Account Information — [DECEASED_FULL_NAME]',
  '[EXECUTOR_NAME]
[EXECUTOR_ADDRESS]
[DATE]

[INSTITUTION_NAME]
[INSTITUTION_ADDRESS]

Re: Notification of Death — [DECEASED_FULL_NAME]
Account Number(s): [ACCOUNT_NUMBER]

Dear [INSTITUTION_NAME]:

I am writing to formally notify [INSTITUTION_NAME] of the death of [DECEASED_FULL_NAME], who passed away on [DATE_OF_DEATH].

I, [EXECUTOR_NAME], am the [EXECUTOR_RELATIONSHIP] of [DECEASED_FULL_NAME] and have been appointed Executor of the Estate. Letters Testamentary were issued by the [PROBATE_COURT_NAME] on [LETTERS_DATE], a certified copy of which is enclosed.

I am requesting that [INSTITUTION_NAME]:
  1. Freeze or flag all accounts associated with [DECEASED_FULL_NAME] to prevent unauthorized transactions;
  2. Provide a complete account statement as of [DATE_OF_DEATH], including all account numbers, balances, and any pending transactions;
  3. Advise me of the process for closing the account(s) and transferring any remaining funds to the estate.

Please also advise whether any accounts were held jointly or had a named beneficiary on file, as this will affect the transfer process.

Enclosed please find:
  - Certified Death Certificate
  - Certified copy of Letters Testamentary (or, if applicable, Small Estate Affidavit)
  - My government-issued photo ID

Please confirm receipt and contact me to discuss next steps. I can be reached at [EXECUTOR_EMAIL] or [EXECUTOR_PHONE].

Sincerely,

[EXECUTOR_NAME]
[EXECUTOR_RELATIONSHIP], Estate of [DECEASED_FULL_NAME]
[EXECUTOR_ADDRESS]
[EXECUTOR_EMAIL]
[EXECUTOR_PHONE]

Enclosures: As listed above',
  ARRAY['bank', 'financial institution', 'accounts', 'notification']
),

(
  'Credit Card Company Notification Letter',
  'Financial Accounts',
  'letter',
  'Notification of Death and Account Closure Request — [DECEASED_FULL_NAME]',
  '[EXECUTOR_NAME]
[EXECUTOR_ADDRESS]
[DATE]

[CREDIT_CARD_COMPANY_NAME]
[CREDIT_CARD_COMPANY_ADDRESS]

Re: Notification of Death and Account Closure — [DECEASED_FULL_NAME]
Account Number: [ACCOUNT_NUMBER] (last four digits: [LAST_FOUR])

Dear [CREDIT_CARD_COMPANY_NAME] Customer Service:

I am writing to notify [CREDIT_CARD_COMPANY_NAME] of the death of [DECEASED_FULL_NAME], who passed away on [DATE_OF_DEATH].

I, [EXECUTOR_NAME], am the [EXECUTOR_RELATIONSHIP] of [DECEASED_FULL_NAME] and am responsible for administering the estate.

I am requesting that you:
  1. Close all credit card accounts held in the name of [DECEASED_FULL_NAME], effective [DATE_OF_DEATH];
  2. Provide a final account statement showing the balance as of [DATE_OF_DEATH];
  3. Advise me of the process for resolving any outstanding balance from estate funds;
  4. Cancel any automatic charges or recurring payments associated with the account;
  5. Remove any authorized users if applicable.

Please note that any charges incurred after [DATE_OF_DEATH] should be reversed as the cardholder was deceased.

Enclosed please find:
  - Certified Death Certificate
  - Certified copy of Letters Testamentary (or Small Estate Affidavit)
  - My government-issued photo ID

Please confirm receipt and provide written confirmation of account closure. If the estate owes a balance, please submit a formal claim to the estate at the address above. I can be reached at [EXECUTOR_EMAIL] or [EXECUTOR_PHONE].

Sincerely,

[EXECUTOR_NAME]
[EXECUTOR_RELATIONSHIP], Estate of [DECEASED_FULL_NAME]
[EXECUTOR_ADDRESS]
[EXECUTOR_EMAIL]
[EXECUTOR_PHONE]

Enclosures: As listed above',
  ARRAY['credit card', 'financial', 'accounts', 'closure', 'notification']
),

(
  'Life Insurance Claim Letter',
  'Financial Accounts',
  'letter',
  'Life Insurance Claim — Policy No. [POLICY_NUMBER] — [DECEASED_FULL_NAME]',
  '[BENEFICIARY_NAME]
[BENEFICIARY_ADDRESS]
[DATE]

[INSURANCE_COMPANY_NAME]
[INSURANCE_COMPANY_ADDRESS]

Re: Life Insurance Claim — Policy No. [POLICY_NUMBER]
Insured: [DECEASED_FULL_NAME]
Date of Death: [DATE_OF_DEATH]

Dear Claims Department:

I am writing to submit a claim for life insurance benefits under Policy No. [POLICY_NUMBER] issued to [DECEASED_FULL_NAME], who passed away on [DATE_OF_DEATH] in [CITY_OF_DEATH], [ESTATE_STATE].

I, [BENEFICIARY_NAME], am listed as [PRIMARY / CONTINGENT] beneficiary under this policy. My relationship to the insured is: [BENEFICIARY_RELATIONSHIP].

I am requesting that the death benefit in the amount of $[POLICY_FACE_VALUE] (or as otherwise determined by your records) be paid to me as designated beneficiary.

Enclosed please find the following documentation in support of this claim:
  - Completed claim form (enclosed / or please send to me at the address above)
  - Certified Death Certificate
  - Original or copy of the policy (if available)
  - [BENEFICIARY_IDENTIFICATION_DOCUMENT] (government-issued photo ID)

Please advise me of any additional documentation required to process this claim. I prefer to receive the benefit payment via [CHECK / DIRECT DEPOSIT], and my banking information is enclosed separately.

I understand this process may take several weeks. Please confirm receipt of this letter and contact me with any questions.

Sincerely,

[BENEFICIARY_NAME]
Beneficiary
[BENEFICIARY_ADDRESS]
[BENEFICIARY_EMAIL]
[BENEFICIARY_PHONE]

Enclosures: As listed above',
  ARRAY['life insurance', 'claim', 'financial', 'insurance']
),

(
  'Pension Administrator Notification Letter',
  'Financial Accounts',
  'letter',
  'Notification of Death and Survivor Benefits Inquiry — [DECEASED_FULL_NAME]',
  '[EXECUTOR_NAME]
[EXECUTOR_ADDRESS]
[DATE]

[PENSION_PLAN_NAME]
[PENSION_ADMINISTRATOR_ADDRESS]

Re: Notification of Death — [DECEASED_FULL_NAME]
Participant ID / SSN: [PARTICIPANT_ID]
Plan Name: [PENSION_PLAN_NAME]

Dear Plan Administrator:

I am writing to notify you of the death of [DECEASED_FULL_NAME], a plan participant, who passed away on [DATE_OF_DEATH].

I, [EXECUTOR_NAME], am the [EXECUTOR_RELATIONSHIP] of [DECEASED_FULL_NAME] and am administering the estate.

I am writing to:
  1. Formally notify the plan of the participant''s death;
  2. Request information regarding any survivor or beneficiary benefits available under the plan;
  3. Request a statement of any accrued but unpaid benefits as of [DATE_OF_DEATH];
  4. Obtain the applicable claim forms for processing any benefit payments due to the estate or named beneficiaries.

Please also confirm the name(s) of any designated beneficiary on file for this account, as this will determine the appropriate next steps.

Enclosed please find:
  - Certified Death Certificate
  - Certified copy of Letters Testamentary (if applicable)
  - My government-issued photo ID

Please confirm receipt of this notice and provide the appropriate claim forms at your earliest convenience. I can be reached at [EXECUTOR_EMAIL] or [EXECUTOR_PHONE].

Sincerely,

[EXECUTOR_NAME]
[EXECUTOR_RELATIONSHIP], Estate of [DECEASED_FULL_NAME]
[EXECUTOR_ADDRESS]
[EXECUTOR_EMAIL]
[EXECUTOR_PHONE]

Enclosures: As listed above',
  ARRAY['pension', 'retirement', 'financial', 'survivor benefits', 'notification']
),

(
  '401k / IRA Beneficiary Claim Letter',
  'Financial Accounts',
  'letter',
  'Beneficiary Claim — Retirement Account — [DECEASED_FULL_NAME]',
  '[BENEFICIARY_NAME]
[BENEFICIARY_ADDRESS]
[DATE]

[FINANCIAL_INSTITUTION_NAME]
[FINANCIAL_INSTITUTION_ADDRESS]

Re: Beneficiary Claim — Retirement Account
Account Holder: [DECEASED_FULL_NAME]
Account Number: [ACCOUNT_NUMBER]
Date of Death: [DATE_OF_DEATH]

Dear Retirement Services Department:

I am writing to submit a beneficiary claim for the retirement account(s) held by [DECEASED_FULL_NAME], who passed away on [DATE_OF_DEATH].

I, [BENEFICIARY_NAME], am listed as [PRIMARY / CONTINGENT] beneficiary for Account No. [ACCOUNT_NUMBER]. My relationship to the deceased account holder is: [BENEFICIARY_RELATIONSHIP].

I am requesting guidance on the options available to me as a beneficiary for this account, including:
  - Distribution options (lump sum, rollover to inherited IRA, required minimum distributions)
  - Applicable tax implications
  - Required forms and documentation for processing the claim

Enclosed please find:
  - Certified Death Certificate
  - Completed beneficiary claim form (enclosed / or please send to the address above)
  - My government-issued photo ID
  - [MY_SOCIAL_SECURITY_NUMBER] (provided separately for identity verification)

Please advise me of the timeline for processing and any additional documentation required. I understand I may have specific deadlines to elect distribution options and would appreciate your guidance on these requirements.

Sincerely,

[BENEFICIARY_NAME]
Beneficiary
[BENEFICIARY_ADDRESS]
[BENEFICIARY_EMAIL]
[BENEFICIARY_PHONE]

Enclosures: As listed above',
  ARRAY['401k', 'IRA', 'retirement', 'financial', 'beneficiary claim']
),

(
  'Investment / Brokerage Account Notification Letter',
  'Financial Accounts',
  'letter',
  'Notification of Death and Account Transfer Request — [DECEASED_FULL_NAME]',
  '[EXECUTOR_NAME]
[EXECUTOR_ADDRESS]
[DATE]

[BROKERAGE_FIRM_NAME]
[BROKERAGE_FIRM_ADDRESS]

Re: Notification of Death and Account Transfer — [DECEASED_FULL_NAME]
Account Number(s): [ACCOUNT_NUMBER]

Dear [BROKERAGE_FIRM_NAME]:

I am writing to formally notify [BROKERAGE_FIRM_NAME] of the death of [DECEASED_FULL_NAME], who passed away on [DATE_OF_DEATH].

I, [EXECUTOR_NAME], have been appointed Executor of the Estate of [DECEASED_FULL_NAME] by the [PROBATE_COURT_NAME]. Letters Testamentary were issued on [LETTERS_DATE].

I am requesting that [BROKERAGE_FIRM_NAME]:
  1. Freeze Account No. [ACCOUNT_NUMBER] to prevent any unauthorized transactions;
  2. Provide a complete account statement including all holdings and values as of [DATE_OF_DEATH];
  3. Advise me of any named beneficiaries or transfer-on-death (TOD) designations on the account;
  4. Provide the appropriate forms to transfer or liquidate the account.

Please note that if the account has a valid TOD designation, I understand the assets may pass directly to the named beneficiary outside of probate. Please advise accordingly.

Enclosed please find:
  - Certified Death Certificate
  - Certified copy of Letters Testamentary
  - My government-issued photo ID

Please confirm receipt and advise me of the next steps. I can be reached at [EXECUTOR_EMAIL] or [EXECUTOR_PHONE].

Sincerely,

[EXECUTOR_NAME]
Executor, Estate of [DECEASED_FULL_NAME]
[EXECUTOR_ADDRESS]
[EXECUTOR_EMAIL]
[EXECUTOR_PHONE]

Enclosures: As listed above',
  ARRAY['brokerage', 'investment', 'stocks', 'financial', 'accounts']
),

(
  'Annuity Claim Letter',
  'Financial Accounts',
  'letter',
  'Annuity Death Benefit Claim — Contract No. [CONTRACT_NUMBER] — [DECEASED_FULL_NAME]',
  '[BENEFICIARY_NAME]
[BENEFICIARY_ADDRESS]
[DATE]

[INSURANCE_COMPANY_NAME]
[INSURANCE_COMPANY_ADDRESS]

Re: Annuity Death Benefit Claim — Contract No. [CONTRACT_NUMBER]
Annuitant / Contract Owner: [DECEASED_FULL_NAME]
Date of Death: [DATE_OF_DEATH]

Dear Annuity Services Department:

I am writing to submit a death benefit claim under Annuity Contract No. [CONTRACT_NUMBER], held by [DECEASED_FULL_NAME], who passed away on [DATE_OF_DEATH].

I, [BENEFICIARY_NAME], am listed as [PRIMARY / CONTINGENT] beneficiary under this contract. My relationship to the annuitant is: [BENEFICIARY_RELATIONSHIP].

I am requesting:
  1. Confirmation of the death benefit amount payable under this contract;
  2. The applicable claim forms for processing this benefit;
  3. Information on available payout options, including any spousal continuation provisions if applicable;
  4. The applicable tax forms I will receive in connection with this distribution.

Enclosed please find:
  - Certified Death Certificate
  - My government-issued photo ID
  - [BENEFICIARY_SOCIAL_SECURITY_NUMBER] (provided for tax reporting purposes)

Please advise me of the documentation required to complete this claim and the expected processing timeline. I can be reached at [BENEFICIARY_EMAIL] or [BENEFICIARY_PHONE].

Sincerely,

[BENEFICIARY_NAME]
Beneficiary
[BENEFICIARY_ADDRESS]
[BENEFICIARY_EMAIL]
[BENEFICIARY_PHONE]

Enclosures: As listed above',
  ARRAY['annuity', 'insurance', 'financial', 'death benefit', 'beneficiary']
),

(
  'Credit Bureau Deceased Notification Letter',
  'Financial Accounts',
  'letter',
  'Notification of Death — [DECEASED_FULL_NAME] — Credit File Update Request',
  '[EXECUTOR_NAME]
[EXECUTOR_ADDRESS]
[DATE]

[CREDIT_BUREAU_NAME]
[CREDIT_BUREAU_ADDRESS]

Re: Notification of Death — [DECEASED_FULL_NAME]
Social Security Number: [DECEASED_SSN]
Date of Birth: [DECEASED_DATE_OF_BIRTH]

Dear [CREDIT_BUREAU_NAME]:

I am writing to notify [CREDIT_BUREAU_NAME] of the death of [DECEASED_FULL_NAME], Social Security Number [DECEASED_SSN], who passed away on [DATE_OF_DEATH].

I, [EXECUTOR_NAME], am the [EXECUTOR_RELATIONSHIP] of [DECEASED_FULL_NAME].

I am requesting that [CREDIT_BUREAU_NAME]:
  1. Flag the credit file of [DECEASED_FULL_NAME] as "deceased" to prevent identity theft and fraudulent new credit applications;
  2. Provide a final credit report for the estate''s records;
  3. Confirm in writing that the "deceased" indicator has been added to the file.

This notification is being submitted to protect the estate and surviving family members from identity fraud involving the deceased''s personal information.

Enclosed please find:
  - Certified Death Certificate
  - My government-issued photo ID
  - Certified copy of Letters Testamentary (or Small Estate Affidavit)

Note: This same letter is being sent to all three major credit bureaus (Equifax, Experian, and TransUnion) simultaneously.

Please confirm receipt and the effective date of the "deceased" flag. If you have questions, I can be reached at [EXECUTOR_EMAIL] or [EXECUTOR_PHONE].

Sincerely,

[EXECUTOR_NAME]
[EXECUTOR_RELATIONSHIP], Estate of [DECEASED_FULL_NAME]
[EXECUTOR_ADDRESS]
[EXECUTOR_EMAIL]
[EXECUTOR_PHONE]

Enclosures: As listed above',
  ARRAY['credit bureau', 'credit', 'identity protection', 'financial', 'notification']
),

(
  'Treasury / Savings Bond Redemption Letter',
  'Financial Accounts',
  'letter',
  'Request for Redemption of U.S. Savings Bonds — Estate of [DECEASED_FULL_NAME]',
  '[EXECUTOR_NAME]
[EXECUTOR_ADDRESS]
[DATE]

Treasury Retail Securities Services
P.O. Box 9150
Minneapolis, MN 55480-9150

Re: Redemption of U.S. Savings Bonds — Estate of [DECEASED_FULL_NAME]
Date of Death: [DATE_OF_DEATH]

Dear Treasury Retail Securities Services:

I am writing to request redemption of U.S. Savings Bond(s) held by [DECEASED_FULL_NAME], who passed away on [DATE_OF_DEATH].

I, [EXECUTOR_NAME], am the Executor of the Estate of [DECEASED_FULL_NAME], as evidenced by the enclosed Letters Testamentary.

The following bond(s) are being submitted for redemption:

  Bond Serial Number: [BOND_SERIAL_NUMBER]
  Bond Series / Denomination: [BOND_SERIES]
  Issue Date: [BOND_ISSUE_DATE]
  Current Value (estimated): $[BOND_VALUE]

[Additional bonds listed separately if applicable.]

I am requesting that the redemption proceeds be paid by check made out to "Estate of [DECEASED_FULL_NAME]" and mailed to the executor address above, or direct deposited to the estate account as described on the enclosed Form PD F 1048.

Enclosed please find:
  - Original paper bond(s) (if paper series)
  - Form PD F 1048 (Claim for Lost, Stolen, or Destroyed U.S. Savings Bonds) or FS Form 5336 (Payment to Estate)
  - Certified Death Certificate
  - Certified copy of Letters Testamentary
  - My government-issued photo ID

Please confirm receipt and advise me of the processing timeline.

Respectfully,

[EXECUTOR_NAME]
Executor, Estate of [DECEASED_FULL_NAME]
[EXECUTOR_ADDRESS]
[EXECUTOR_EMAIL]
[EXECUTOR_PHONE]

Enclosures: As listed above',
  ARRAY['savings bonds', 'treasury', 'financial', 'redemption']
),

(
  'IRS Estate EIN Application Cover Letter',
  'Financial Accounts',
  'letter',
  'EIN Application for Estate — Estate of [DECEASED_FULL_NAME]',
  '[EXECUTOR_NAME]
[EXECUTOR_ADDRESS]
[DATE]

Internal Revenue Service
Attn: EIN Operation
Cincinnati, OH 45999

Re: Application for Employer Identification Number — Estate of [DECEASED_FULL_NAME]
Date of Death: [DATE_OF_DEATH]
Responsible Party (Executor): [EXECUTOR_NAME]

Dear IRS:

I am submitting this letter and the enclosed Form SS-4 to apply for an Employer Identification Number (EIN) for the Estate of [DECEASED_FULL_NAME].

[DECEASED_FULL_NAME] passed away on [DATE_OF_DEATH] in [CITY_OF_DEATH], [ESTATE_STATE]. I, [EXECUTOR_NAME], have been appointed Executor of the estate and am required to obtain an EIN for purposes of:
  - Opening an estate bank account
  - Filing Form 1041 (U.S. Income Tax Return for Estates and Trusts) if required
  - Receiving income on behalf of the estate

The estate''s estimated income for the period of administration is $[ESTIMATED_ESTATE_INCOME].

Note: An EIN may also be obtained immediately and at no cost via the IRS online application at irs.gov/businesses/small-businesses-self-employed/apply-for-an-employer-identification-number-ein-online. The online process is generally faster than this paper application.

Enclosed please find:
  - Form SS-4 (Application for Employer Identification Number)
  - Certified Death Certificate

If you require additional information, please contact me at [EXECUTOR_EMAIL] or [EXECUTOR_PHONE].

Respectfully,

[EXECUTOR_NAME]
Executor, Estate of [DECEASED_FULL_NAME]
[EXECUTOR_ADDRESS]
[EXECUTOR_EMAIL]
[EXECUTOR_PHONE]

Enclosures: As listed above',
  ARRAY['IRS', 'EIN', 'tax', 'estate', 'financial']
),

-- ──────────────────────────────────────────────────────────────────────────────
-- PROPERTY & HOME — 4 letters
-- ──────────────────────────────────────────────────────────────────────────────

(
  'Landlord Death Notification Letter',
  'Property & Home',
  'letter',
  'Notification of Tenant''s Death — [DECEASED_FULL_NAME]',
  '[EXECUTOR_NAME]
[EXECUTOR_ADDRESS]
[DATE]

[LANDLORD_NAME]
[LANDLORD_ADDRESS]

Re: Notification of Tenant''s Death — [DECEASED_FULL_NAME]
Property Address: [RENTAL_PROPERTY_ADDRESS]
Lease / Unit: [UNIT_NUMBER]

Dear [LANDLORD_NAME]:

I am writing to notify you of the death of [DECEASED_FULL_NAME], who was a tenant at [RENTAL_PROPERTY_ADDRESS], and passed away on [DATE_OF_DEATH].

I, [EXECUTOR_NAME], am the [EXECUTOR_RELATIONSHIP] of [DECEASED_FULL_NAME] and am administering the estate.

I am writing to address the following matters:
  1. Provide formal notice of the tenant''s death as required under the lease agreement;
  2. Discuss the termination of the lease, effective [PROPOSED_LEASE_END_DATE];
  3. Arrange for removal of the deceased''s personal property from the unit;
  4. Ensure the return of any security deposit held on the account ($[SECURITY_DEPOSIT_AMOUNT]).

I would appreciate the opportunity to speak with you at your earliest convenience to coordinate access to the unit and agree on a timeline for vacating. I will ensure the property is left in proper condition.

Please advise me of your procedures and any documentation you require from the estate.

Sincerely,

[EXECUTOR_NAME]
[EXECUTOR_RELATIONSHIP], Estate of [DECEASED_FULL_NAME]
[EXECUTOR_ADDRESS]
[EXECUTOR_EMAIL]
[EXECUTOR_PHONE]

Enclosure: Certified Death Certificate',
  ARRAY['landlord', 'rental', 'lease', 'property', 'notification']
),

(
  'Mortgage Servicer Notification Letter',
  'Property & Home',
  'letter',
  'Notification of Borrower''s Death — [DECEASED_FULL_NAME] — Loan No. [LOAN_NUMBER]',
  '[EXECUTOR_NAME]
[EXECUTOR_ADDRESS]
[DATE]

[MORTGAGE_SERVICER_NAME]
[MORTGAGE_SERVICER_ADDRESS]

Re: Notification of Borrower''s Death — [DECEASED_FULL_NAME]
Loan Number: [LOAN_NUMBER]
Property Address: [PROPERTY_ADDRESS]

Dear [MORTGAGE_SERVICER_NAME]:

I am writing to formally notify [MORTGAGE_SERVICER_NAME] of the death of [DECEASED_FULL_NAME], who passed away on [DATE_OF_DEATH]. [DECEASED_FULL_NAME] was the [sole / joint] borrower on Loan No. [LOAN_NUMBER], secured by the property at [PROPERTY_ADDRESS].

I, [EXECUTOR_NAME], am the Executor of the Estate of [DECEASED_FULL_NAME], as evidenced by the enclosed Letters Testamentary.

I am writing to:
  1. Formally notify you of the borrower''s death as required under the loan agreement;
  2. Request a current statement of the outstanding loan balance, interest rate, and payment schedule;
  3. Discuss the options available to the estate, including:
     - Continuing to make payments from estate funds while the property is administered;
     - Refinancing or assuming the loan by a co-borrower or heir;
     - Sale of the property to satisfy the loan.

Please advise me of your process for working with an executor and whether there are any immediate actions required to protect the loan status.

Note: Pursuant to the Garn-St. Germain Act, the "due on sale" clause may not be enforced in certain circumstances involving transfer by inheritance.

Enclosed please find:
  - Certified Death Certificate
  - Certified copy of Letters Testamentary

Please confirm receipt and contact me to discuss next steps. I can be reached at [EXECUTOR_EMAIL] or [EXECUTOR_PHONE].

Sincerely,

[EXECUTOR_NAME]
Executor, Estate of [DECEASED_FULL_NAME]
[EXECUTOR_ADDRESS]
[EXECUTOR_EMAIL]
[EXECUTOR_PHONE]

Enclosures: As listed above',
  ARRAY['mortgage', 'property', 'home', 'loan', 'notification']
),

(
  'HOA / Condo Association Notification Letter',
  'Property & Home',
  'letter',
  'Notification of Owner''s Death — [DECEASED_FULL_NAME] — Unit [UNIT_NUMBER]',
  '[EXECUTOR_NAME]
[EXECUTOR_ADDRESS]
[DATE]

[HOA_NAME]
[HOA_MANAGEMENT_ADDRESS]

Re: Notification of Owner''s Death — [DECEASED_FULL_NAME]
Property Address / Unit: [PROPERTY_ADDRESS], Unit [UNIT_NUMBER]
Account Number: [HOA_ACCOUNT_NUMBER]

Dear [HOA_NAME] Board / Management:

I am writing to notify [HOA_NAME] of the death of [DECEASED_FULL_NAME], who passed away on [DATE_OF_DEATH]. [DECEASED_FULL_NAME] was the owner of Unit [UNIT_NUMBER] at [PROPERTY_ADDRESS].

I, [EXECUTOR_NAME], am the Executor of the Estate of [DECEASED_FULL_NAME] and am responsible for administering the estate, including this property.

I am writing to:
  1. Formally notify the association of the change in ownership status;
  2. Request a current statement of any outstanding dues, assessments, or fees;
  3. Confirm that regular HOA dues will continue to be paid from estate funds during the period of administration;
  4. Update the association''s records and provide my contact information as the authorized representative for this unit.

Please also advise me of any transfer fees, resale packages, or governing documents I should be aware of in connection with the estate administration and eventual transfer or sale of this property.

Enclosed please find:
  - Certified Death Certificate
  - Certified copy of Letters Testamentary (or Small Estate Affidavit)

Sincerely,

[EXECUTOR_NAME]
Executor, Estate of [DECEASED_FULL_NAME]
[EXECUTOR_ADDRESS]
[EXECUTOR_EMAIL]
[EXECUTOR_PHONE]

Enclosures: As listed above',
  ARRAY['HOA', 'condo', 'property', 'homeowners association', 'notification']
),

(
  'Vehicle Lease Termination Letter',
  'Property & Home',
  'letter',
  'Early Lease Termination Due to Death — [DECEASED_FULL_NAME] — Account [ACCOUNT_NUMBER]',
  '[EXECUTOR_NAME]
[EXECUTOR_ADDRESS]
[DATE]

[LEASE_COMPANY_NAME]
[LEASE_COMPANY_ADDRESS]

Re: Early Lease Termination Due to Death of Lessee — [DECEASED_FULL_NAME]
Lease Account Number: [ACCOUNT_NUMBER]
Vehicle: [VEHICLE_YEAR] [VEHICLE_MAKE] [VEHICLE_MODEL], VIN [VEHICLE_VIN]

Dear [LEASE_COMPANY_NAME]:

I am writing to request early termination of the vehicle lease agreement for the above-referenced vehicle, due to the death of the lessee, [DECEASED_FULL_NAME], who passed away on [DATE_OF_DEATH].

I, [EXECUTOR_NAME], am the [EXECUTOR_RELATIONSHIP] of [DECEASED_FULL_NAME] and am administering the estate.

I understand that early termination may result in a fee or remaining balance obligation under the lease terms. Please provide:
  1. The payoff amount required to terminate the lease;
  2. Any early termination fees applicable under the agreement;
  3. Instructions for returning the vehicle;
  4. Confirmation of the final settlement amount that will be due from the estate.

Many lease agreements contain provisions allowing for early termination without penalty upon the death of the lessee. Please advise whether this provision applies to this agreement.

The vehicle is currently located at [VEHICLE_CURRENT_LOCATION] and is in [good / the following] condition: [VEHICLE_CONDITION_NOTES].

Enclosed please find:
  - Certified Death Certificate
  - Certified copy of Letters Testamentary (or Small Estate Affidavit)

Please confirm receipt and advise me of the return and settlement process. I can be reached at [EXECUTOR_EMAIL] or [EXECUTOR_PHONE].

Sincerely,

[EXECUTOR_NAME]
[EXECUTOR_RELATIONSHIP], Estate of [DECEASED_FULL_NAME]
[EXECUTOR_ADDRESS]
[EXECUTOR_EMAIL]
[EXECUTOR_PHONE]

Enclosures: As listed above',
  ARRAY['vehicle', 'lease', 'car', 'property', 'termination']
),

-- ──────────────────────────────────────────────────────────────────────────────
-- PERSONAL & SERVICES — 7 letters
-- ──────────────────────────────────────────────────────────────────────────────

(
  'Health Insurance Cancellation Letter',
  'Personal & Memberships',
  'letter',
  'Request for Policy Cancellation Due to Death — [DECEASED_FULL_NAME] — Policy [POLICY_NUMBER]',
  '[EXECUTOR_NAME]
[EXECUTOR_ADDRESS]
[DATE]

[INSURANCE_COMPANY_NAME]
[INSURANCE_COMPANY_ADDRESS]

Re: Request for Health Insurance Policy Cancellation — [DECEASED_FULL_NAME]
Policy Number: [POLICY_NUMBER]
Date of Death: [DATE_OF_DEATH]

Dear [INSURANCE_COMPANY_NAME]:

I am writing to request cancellation of the health insurance policy(ies) held by [DECEASED_FULL_NAME], who passed away on [DATE_OF_DEATH].

I, [EXECUTOR_NAME], am the [EXECUTOR_RELATIONSHIP] of [DECEASED_FULL_NAME].

Please cancel Policy No. [POLICY_NUMBER] effective [DATE_OF_DEATH] and:
  1. Provide a final accounting of any outstanding premiums or refunds due;
  2. Confirm in writing that the policy is cancelled and any automatic premium drafts have been stopped;
  3. If there are any outstanding claims in process for dates of service prior to [DATE_OF_DEATH], please continue processing those claims and direct payment to the estate;
  4. If any dependents are covered under this policy, advise me regarding COBRA continuation coverage or conversion options available to them.

Enclosed please find:
  - Certified Death Certificate

Please confirm receipt and the effective cancellation date. If any premium refund is due, please issue payment to "Estate of [DECEASED_FULL_NAME]" at the executor address above. I can be reached at [EXECUTOR_EMAIL] or [EXECUTOR_PHONE].

Sincerely,

[EXECUTOR_NAME]
[EXECUTOR_RELATIONSHIP], Estate of [DECEASED_FULL_NAME]
[EXECUTOR_ADDRESS]
[EXECUTOR_EMAIL]
[EXECUTOR_PHONE]

Enclosure: Certified Death Certificate',
  ARRAY['health insurance', 'insurance', 'cancellation', 'policy']
),

(
  'Cell Phone Carrier Notification Letter',
  'Personal & Memberships',
  'letter',
  'Account Cancellation Due to Death — [DECEASED_FULL_NAME] — Account [ACCOUNT_NUMBER]',
  '[EXECUTOR_NAME]
[EXECUTOR_ADDRESS]
[DATE]

[CARRIER_NAME] Customer Service
[CARRIER_ADDRESS]

Re: Account Cancellation Due to Death — [DECEASED_FULL_NAME]
Account Number: [ACCOUNT_NUMBER]
Phone Number(s): [PHONE_NUMBER]

Dear [CARRIER_NAME] Customer Service:

I am writing to cancel the wireless service account(s) held by [DECEASED_FULL_NAME], who passed away on [DATE_OF_DEATH].

I, [EXECUTOR_NAME], am the [EXECUTOR_RELATIONSHIP] of [DECEASED_FULL_NAME].

Please cancel Account No. [ACCOUNT_NUMBER] and all associated lines effective [DATE_OF_DEATH] and:
  1. Stop all billing and automatic payments effective immediately;
  2. Provide a final account statement and confirm any outstanding balance or refund due;
  3. If there are any early termination fees, please advise whether your policy provides a waiver in the event of a subscriber''s death;
  4. Retain or transfer any remaining device payments in accordance with estate obligations.

Enclosed please find:
  - Certified Death Certificate

Please confirm cancellation and advise me of any final balance due or refund owed. Correspondence may be sent to the executor address above. I can be reached at [EXECUTOR_EMAIL] or [EXECUTOR_PHONE].

Sincerely,

[EXECUTOR_NAME]
[EXECUTOR_RELATIONSHIP], Estate of [DECEASED_FULL_NAME]
[EXECUTOR_ADDRESS]
[EXECUTOR_EMAIL]
[EXECUTOR_PHONE]

Enclosure: Certified Death Certificate',
  ARRAY['cell phone', 'wireless', 'carrier', 'cancellation', 'services']
),

(
  'Utility Service Cancellation Letter',
  'Personal & Memberships',
  'letter',
  'Service Cancellation or Transfer Due to Death — [DECEASED_FULL_NAME] — Account [ACCOUNT_NUMBER]',
  '[EXECUTOR_NAME]
[EXECUTOR_ADDRESS]
[DATE]

[UTILITY_COMPANY_NAME]
[UTILITY_COMPANY_ADDRESS]

Re: Service Cancellation / Transfer Due to Death — [DECEASED_FULL_NAME]
Account Number: [ACCOUNT_NUMBER]
Service Address: [SERVICE_ADDRESS]

Dear [UTILITY_COMPANY_NAME] Customer Service:

I am writing regarding the utility account held by [DECEASED_FULL_NAME], who passed away on [DATE_OF_DEATH].

I, [EXECUTOR_NAME], am the [EXECUTOR_RELATIONSHIP] of [DECEASED_FULL_NAME].

I am requesting that you [CANCEL / TRANSFER] the above-referenced account, effective [REQUESTED_DATE]:

If cancelling:
  - Please disconnect service at [SERVICE_ADDRESS] effective [CANCELLATION_DATE];
  - Provide a final bill and confirm the closing balance;
  - Return any deposit on file to the estate at the executor address above.

If transferring to a new account holder:
  - Please transfer service to [NEW_ACCOUNT_HOLDER_NAME];
  - New billing address: [NEW_BILLING_ADDRESS];
  - Contact: [NEW_CONTACT_PHONE].

Enclosed please find:
  - Certified Death Certificate

Please confirm receipt of this request and advise of next steps. I can be reached at [EXECUTOR_EMAIL] or [EXECUTOR_PHONE].

Sincerely,

[EXECUTOR_NAME]
[EXECUTOR_RELATIONSHIP], Estate of [DECEASED_FULL_NAME]
[EXECUTOR_ADDRESS]
[EXECUTOR_EMAIL]
[EXECUTOR_PHONE]

Enclosure: Certified Death Certificate',
  ARRAY['utility', 'services', 'cancellation', 'electricity', 'gas', 'water']
),

(
  'Subscription Cancellation Letter',
  'Personal & Memberships',
  'letter',
  'Account Cancellation Due to Death — [DECEASED_FULL_NAME] — Account [ACCOUNT_NUMBER]',
  '[EXECUTOR_NAME]
[EXECUTOR_ADDRESS]
[DATE]

[COMPANY_NAME]
[COMPANY_ADDRESS]

Re: Account Cancellation Due to Death — [DECEASED_FULL_NAME]
Account Number / Username: [ACCOUNT_NUMBER]
Date of Death: [DATE_OF_DEATH]

Dear [COMPANY_NAME] Customer Service:

I am writing to request cancellation of all accounts, subscriptions, and services held by [DECEASED_FULL_NAME], who passed away on [DATE_OF_DEATH].

I, [EXECUTOR_NAME], am the [EXECUTOR_RELATIONSHIP] of [DECEASED_FULL_NAME].

Please:
  1. Cancel Account No. [ACCOUNT_NUMBER] immediately;
  2. Stop all recurring charges and automatic payments effective [DATE_OF_DEATH];
  3. Refund any prepaid or unused subscription amounts to the estate;
  4. Delete or memorialize the account in accordance with your bereavement policy;
  5. Provide written confirmation of the cancellation.

Please issue any applicable refund by check to "Estate of [DECEASED_FULL_NAME]" at the executor address above.

Enclosed please find:
  - Certified Death Certificate
  - My government-issued photo ID (if required)

Sincerely,

[EXECUTOR_NAME]
[EXECUTOR_RELATIONSHIP], Estate of [DECEASED_FULL_NAME]
[EXECUTOR_ADDRESS]
[EXECUTOR_EMAIL]
[EXECUTOR_PHONE]

Enclosure: Certified Death Certificate',
  ARRAY['subscription', 'membership', 'cancellation', 'services']
),

(
  'Alumni Association Membership Letter',
  'Personal & Memberships',
  'letter',
  'Notification of Member''s Death — [DECEASED_FULL_NAME]',
  '[EXECUTOR_NAME]
[EXECUTOR_ADDRESS]
[DATE]

[ALUMNI_ASSOCIATION_NAME]
[ALUMNI_ASSOCIATION_ADDRESS]

Re: Notification of Member''s Death — [DECEASED_FULL_NAME]
Graduation Year: [GRADUATION_YEAR]
Member ID (if known): [MEMBER_ID]

Dear [ALUMNI_ASSOCIATION_NAME]:

I am writing to notify [ALUMNI_ASSOCIATION_NAME] of the death of [DECEASED_FULL_NAME], a proud alumnus/alumna of the Class of [GRADUATION_YEAR], who passed away on [DATE_OF_DEATH].

I, [EXECUTOR_NAME], am the [EXECUTOR_RELATIONSHIP] of [DECEASED_FULL_NAME].

I am requesting that you:
  1. Update your records to reflect the passing of [DECEASED_FULL_NAME];
  2. Cancel any recurring membership dues or magazine subscriptions associated with the account;
  3. Provide information regarding any memorial or tribute programs available through the association.

Any outstanding balance or refund due may be addressed to the estate at the executor address above.

We are grateful for the connection [DECEASED_FULL_NAME] maintained with [INSTITUTION_NAME] throughout the years.

Sincerely,

[EXECUTOR_NAME]
[EXECUTOR_RELATIONSHIP], Estate of [DECEASED_FULL_NAME]
[EXECUTOR_ADDRESS]
[EXECUTOR_EMAIL]
[EXECUTOR_PHONE]

Enclosure: Certified Death Certificate',
  ARRAY['alumni', 'membership', 'association', 'notification']
),

(
  'Professional Association Membership Cancellation Letter',
  'Personal & Memberships',
  'letter',
  'Notification of Member''s Death and Membership Cancellation — [DECEASED_FULL_NAME]',
  '[EXECUTOR_NAME]
[EXECUTOR_ADDRESS]
[DATE]

[ASSOCIATION_NAME]
[ASSOCIATION_ADDRESS]

Re: Notification of Member''s Death — [DECEASED_FULL_NAME]
Member ID (if known): [MEMBER_ID]
Date of Death: [DATE_OF_DEATH]

Dear [ASSOCIATION_NAME]:

I am writing to notify [ASSOCIATION_NAME] of the death of [DECEASED_FULL_NAME], a member of your organization, who passed away on [DATE_OF_DEATH].

I, [EXECUTOR_NAME], am the [EXECUTOR_RELATIONSHIP] of [DECEASED_FULL_NAME].

Please:
  1. Update your records to reflect [DECEASED_FULL_NAME]''s passing;
  2. Cancel the membership and any associated dues, publications, or benefits effective [DATE_OF_DEATH];
  3. Refund any prepaid dues for the period following [DATE_OF_DEATH] to the estate.

Please issue any applicable refund by check to "Estate of [DECEASED_FULL_NAME]" at the executor address above.

Enclosed please find a certified copy of the Death Certificate.

Sincerely,

[EXECUTOR_NAME]
[EXECUTOR_RELATIONSHIP], Estate of [DECEASED_FULL_NAME]
[EXECUTOR_ADDRESS]
[EXECUTOR_EMAIL]
[EXECUTOR_PHONE]

Enclosure: Certified Death Certificate',
  ARRAY['professional association', 'membership', 'cancellation', 'notification']
),

(
  'Professional License Cancellation Letter',
  'Personal & Memberships',
  'letter',
  'Notification of Licensee''s Death — [DECEASED_FULL_NAME] — License No. [LICENSE_NUMBER]',
  '[EXECUTOR_NAME]
[EXECUTOR_ADDRESS]
[DATE]

[LICENSING_BOARD_NAME]
[LICENSING_BOARD_ADDRESS]

Re: Notification of Licensee''s Death — [DECEASED_FULL_NAME]
License Type: [LICENSE_TYPE]
License Number: [LICENSE_NUMBER]
Date of Death: [DATE_OF_DEATH]

Dear [LICENSING_BOARD_NAME]:

I am writing to formally notify [LICENSING_BOARD_NAME] of the death of [DECEASED_FULL_NAME], holder of [LICENSE_TYPE] License No. [LICENSE_NUMBER], who passed away on [DATE_OF_DEATH].

I, [EXECUTOR_NAME], am the [EXECUTOR_RELATIONSHIP] of [DECEASED_FULL_NAME].

I am requesting that you:
  1. Inactivate or retire License No. [LICENSE_NUMBER] in your records effective [DATE_OF_DEATH];
  2. Cancel any pending license renewal obligations;
  3. Advise me of any actions required by the estate in connection with this license (e.g., business records retention, client notification requirements if applicable).

Enclosed please find:
  - Certified Death Certificate
  - Certified copy of Letters Testamentary (if required)

Please confirm receipt and advise of any further steps required. I can be reached at [EXECUTOR_EMAIL] or [EXECUTOR_PHONE].

Sincerely,

[EXECUTOR_NAME]
[EXECUTOR_RELATIONSHIP], Estate of [DECEASED_FULL_NAME]
[EXECUTOR_ADDRESS]
[EXECUTOR_EMAIL]
[EXECUTOR_PHONE]

Enclosures: As listed above',
  ARRAY['professional license', 'license', 'notification', 'cancellation']
)

ON CONFLICT (name) DO NOTHING;

-- ──────────────────────────────────────────────────────────────────────────────
-- GUIDES (7)
-- ──────────────────────────────────────────────────────────────────────────────

INSERT INTO public.templates (name, category, type, content, tags) VALUES

(
  'How to Obtain a Certified Death Certificate',
  'Government & Benefits',
  'guide',
  'HOW TO OBTAIN A CERTIFIED DEATH CERTIFICATE
Guide for Executors and Family Members

OVERVIEW
A certified death certificate is a legal document issued by the state vital records office confirming an individual''s death. You will need multiple certified copies to administer the estate. This guide explains how many to order, where to order them, and what to expect.

HOW MANY TO ORDER
Order at least 15–20 certified copies. Most families under-order and then wait weeks for more copies while estate tasks stall. Each institution typically requires its own original certified copy (not a photocopy). Some institutions will return originals; many will not.

Plan for one certified copy for each of the following:
- Social Security Administration
- Each bank or credit union
- Each investment or brokerage account
- Each life insurance policy
- Probate court filing
- Medicare / Medicaid
- Veterans Affairs (if applicable)
- DMV / vehicle title transfer
- Each credit card company (one copy may be shared)
- IRS (for EIN application)
- Mortgage servicer
- 3–5 spares

WHERE TO ORDER
The death certificate is issued by the state where the death occurred (not necessarily where the deceased lived).

Option 1 — Funeral Home (most common): The funeral home typically orders death certificates on your behalf as part of their services. Ask how many they will order and confirm before the funeral.

Option 2 — State Vital Records Office: Contact the vital records office of the state where the death occurred. Most states allow online, mail, or in-person ordering.

Option 3 — VitalChek (vitacheck.com): A nationally recognized third-party service authorized by most states. Adds a convenience fee of $10–20 in addition to state fees.

COST AND TIMELINE
Standard fee: $5–$25 per certified copy, depending on the state.
Processing time: 1–4 weeks for mail orders; same-day at some in-person offices.
Expedited processing is often available for an additional fee.

IMPORTANT NOTES
- Only certified copies (with a raised or embossed seal) are accepted by government agencies and most institutions. Photocopies are not sufficient.
- Keep all originals in a secure, fireproof location.
- You can order more copies at any time, but it takes time and requires additional payment. Order generously at the outset.',
  ARRAY['death certificate', 'government', 'vital records', 'guide']
),

(
  'How to Open Probate Court Proceedings',
  'Legal & Probate',
  'guide',
  'HOW TO OPEN PROBATE COURT PROCEEDINGS
Guide for Executors and Administrators

OVERVIEW
Probate is the legal process by which a deceased person''s estate is administered under court supervision. Not all estates require probate. This guide explains when probate is needed, how to open it, and what to expect.

DO YOU NEED PROBATE?
Probate is generally required when:
- The deceased owned assets titled solely in their name (not joint tenancy or community property)
- The total value of those assets exceeds your state''s small estate threshold (typically $10,000–$200,000 depending on state)
- There is no trust or other non-probate transfer mechanism in place

Probate is generally NOT required for:
- Assets with named beneficiaries (life insurance, retirement accounts, POD/TOD accounts)
- Jointly held property passing to the surviving owner
- Assets held in a living trust
- Assets below the small estate threshold (may use affidavit instead)

STEP 1: LOCATE AND REVIEW THE WILL
Find the original signed will. File it with the probate court even if you believe probate is not necessary — most states require it.

STEP 2: DETERMINE THE CORRECT COURT
Probate is filed in the county where the deceased was domiciled at the time of death (principal residence). This is usually the probate court, surrogate''s court, or circuit court depending on your state.

STEP 3: GATHER REQUIRED DOCUMENTS
- Original will (not a copy)
- Certified death certificate (typically 1–2 copies for the court)
- Petition for Probate form (available from the court or court website)
- List of heirs and beneficiaries with contact information
- Estimated value of estate assets

STEP 4: FILE THE PETITION
File the petition with the probate court in the appropriate county. Pay the filing fee ($150–$400 typical, varies by state and estate size). The court will schedule a hearing.

STEP 5: RECEIVE LETTERS TESTAMENTARY
After the court approves the petition, it issues "Letters Testamentary" (if there is a will) or "Letters of Administration" (if there is no will). These are your legal authority to act on behalf of the estate.

STEP 6: PUBLISH CREDITOR NOTICE
Most states require you to publish notice to creditors in a local newspaper and/or mail notice to known creditors. This starts the creditor claim period (typically 3–6 months).

WHAT TO EXPECT
Timeline: Simple estates may close in 6–12 months. Complex estates can take years.
Cost: Court fees, attorney fees (if used), and accounting fees vary widely.
Attorney: Probate is complex. Many executors retain a probate attorney, especially for larger estates, contested wills, or estates with significant real property.',
  ARRAY['probate', 'court', 'legal', 'executor', 'guide']
),

(
  'How to File a Life Insurance Claim',
  'Financial Accounts',
  'guide',
  'HOW TO FILE A LIFE INSURANCE CLAIM
Guide for Beneficiaries and Executors

OVERVIEW
Life insurance benefits are paid directly to named beneficiaries and generally do not pass through probate. This guide explains how to locate policies, submit claims, and receive payment.

STEP 1: LOCATE ALL POLICIES
Check the following sources:
- The deceased''s personal files, filing cabinets, and safe deposit box
- Email inbox (search for "life insurance" or insurer names)
- Bank statements (look for premium deductions)
- Employer HR department (group life insurance is often provided as a workplace benefit)
- Financial advisor records
- The MIB (Medical Information Bureau) Life Insurance Policy Locator: report.mib.com
- NAIC Policy Locator Service: eapps.naic.org

Common types of policies to look for:
- Individual life insurance (term, whole, universal)
- Employer-provided group life insurance
- Mortgage life insurance
- Accidental death and dismemberment (AD&D)
- Burial / final expense policies

STEP 2: CONTACT EACH INSURER
Call the insurance company''s claims department. Provide:
- Policyholder name and date of birth
- Policy number (if known)
- Date of death
- Your name and relationship to the deceased

The insurer will send you a claim packet.

STEP 3: COMPLETE AND SUBMIT THE CLAIM FORM
Each insurer has its own claim form. You will typically need to provide:
- Completed claim form (signed by all beneficiaries)
- Certified death certificate (most insurers require their own original copy)
- Proof of identity (government-issued photo ID)
- The original policy document (if you have it; not always required)

STEP 4: CHOOSE A PAYOUT OPTION
Most insurers offer multiple payout options:
- Lump sum (most common)
- Installment payments
- Interest income option
- Annuity

For most beneficiaries, a lump sum paid to a dedicated savings or investment account is the simplest and most flexible option.

STEP 5: RECEIVE PAYMENT AND REPORT TAXES
Life insurance death benefits are generally income-tax-free to the beneficiary. However, any interest earned on the benefit after the date of death is taxable. Keep records of all payments received and consult a tax professional if the estate is complex.

TIMELINE
Most insurers pay claims within 30–60 days of receiving a complete claim package. Delays occur when:
- Documentation is incomplete
- The death occurred within the first two years of the policy (contestability period)
- The cause of death triggers investigation',
  ARRAY['life insurance', 'claim', 'guide', 'financial', 'beneficiary']
),

(
  'How to Close Financial Accounts and Transfer Assets',
  'Financial Accounts',
  'guide',
  'HOW TO CLOSE FINANCIAL ACCOUNTS AND TRANSFER ASSETS
Guide for Executors and Administrators

OVERVIEW
Closing financial accounts and transferring assets is one of the most time-consuming parts of estate administration. This guide covers banks, investment accounts, retirement accounts, and other financial assets.

BEFORE YOU START
You will need:
- Letters Testamentary or Letters of Administration (your legal authority as executor)
- Multiple certified death certificates (one per institution)
- Estate EIN from the IRS (for opening an estate account)
- Government-issued photo ID

STEP 1: OPEN AN ESTATE BANK ACCOUNT
Open a dedicated checking account in the name of the estate ("Estate of [Name]") at a bank of your choosing. This account:
- Receives incoming estate funds (final paycheck, insurance proceeds, liquidated assets)
- Pays estate expenses (debts, taxes, funeral costs)
- Holds funds for distribution to beneficiaries

To open the account you will need: Letters Testamentary, certified death certificate, estate EIN, and your ID.

STEP 2: INVENTORY ALL ACCOUNTS
Create a complete list of all financial accounts:
- Checking and savings accounts
- Investment and brokerage accounts
- Retirement accounts (401k, IRA, pension)
- CDs and savings bonds
- Cryptocurrency accounts
- PayPal, Venmo, and other payment accounts

For each account, note: institution name, account number, approximate balance, whether it has a named beneficiary or TOD/POD designation, and whether it is joint.

STEP 3: ACCOUNTS WITH NAMED BENEFICIARIES OR TOD/POD
These accounts pass directly to the named beneficiary and do NOT go through probate:
- Life insurance policies
- Retirement accounts (401k, IRA) with named beneficiaries
- Bank accounts with payable-on-death (POD) designations
- Investment accounts with transfer-on-death (TOD) designations

Beneficiaries claim these assets directly by contacting the institution with a death certificate and their own ID.

STEP 4: ACCOUNTS THAT GO THROUGH PROBATE
Accounts held solely in the deceased''s name without TOD/POD designations are probate assets. To close and transfer these:
1. Contact each institution with your Letters Testamentary and a certified death certificate
2. Request a statement of account as of the date of death
3. Transfer funds to the estate account
4. Close the account and obtain written confirmation

STEP 5: JOINT ACCOUNTS
Accounts held jointly with right of survivorship pass directly to the surviving owner. The surviving owner presents a death certificate to the institution to have the deceased''s name removed.

STEP 6: RETIREMENT ACCOUNTS
Retirement accounts are claimed by the named beneficiary, not the estate. See the "How to File a Retirement Account Beneficiary Claim" guide.',
  ARRAY['financial accounts', 'bank', 'assets', 'executor', 'guide']
),

(
  'How to Handle Digital Assets and Online Accounts',
  'Digital Estate',
  'guide',
  'HOW TO HANDLE DIGITAL ASSETS AND ONLINE ACCOUNTS
Guide for Executors and Family Members

OVERVIEW
Digital assets — online accounts, cryptocurrency, domain names, digital files — are increasingly significant parts of an estate. This guide explains how to locate, access, and properly manage them.

WHAT ARE DIGITAL ASSETS?
- Financial: Cryptocurrency (Bitcoin, Ethereum, etc.), PayPal, Venmo, Cash App balances, online banking accounts
- Income-generating: Monetized YouTube/social media accounts, Etsy shops, Amazon seller accounts, domain names and websites
- Stored value: Apple/Google/Amazon store credit, airline miles, hotel points, gift card balances
- Personal: Email accounts, photos, documents stored in cloud services (iCloud, Google Drive, Dropbox)
- Social media: Facebook, Instagram, Twitter/X, LinkedIn profiles

STEP 1: LOCATE ACCOUNTS
Check the following:
- Password manager (1Password, LastPass, Bitwarden) — if the deceased used one, this may contain a complete list
- Browser saved passwords (Chrome, Safari, Firefox)
- Email inbox (search for "welcome," "account," "subscription," "receipt")
- Bank statements (for recurring charges from online services)
- App store purchase history

Note: Unauthorized access to someone''s accounts — even after death — may violate the Computer Fraud and Abuse Act in some situations. Most platforms have formal deceased user processes.

STEP 2: CRYPTOCURRENCY
Cryptocurrency is a critical asset that can be permanently lost if not handled correctly.
- Hardware wallets (Ledger, Trezor): The "seed phrase" or private key is required to access funds. Without it, the funds may be unrecoverable.
- Software wallets / exchanges (Coinbase, Kraken): Contact the exchange directly with death certificate and Letters Testamentary to initiate an account access or transfer request.
- NEVER share seed phrases digitally — handle in person only.

STEP 3: SOCIAL MEDIA ACCOUNTS
Major platforms offer bereavement options:
- Facebook: Memorialize or remove the account at facebook.com/help/contact/234739089954300
- Instagram: Memorialize or remove at help.instagram.com
- Google/Gmail: Submit an Inactive Account Manager request at myaccount.google.com, or use the formal deceased user request form
- LinkedIn: Request removal at linkedin.com/help
- Twitter/X: Request account deactivation at help.twitter.com

STEP 4: EMAIL ACCOUNTS
Email access may contain critical estate-related communications. Options:
- Gmail: Google allows authorized representatives to request content access or deletion. Requires documentation.
- Apple iCloud: Apple does not grant password access but may allow a Digital Legacy contact (if set up) to access data.
- Consider whether to download/archive important emails before closing the account.

STEP 5: DOMAIN NAMES AND WEBSITES
Domain names are transferable property. Contact the domain registrar (GoDaddy, Namecheap, etc.) with Letters Testamentary to transfer or allow a domain to expire.

STEP 6: AIRLINE MILES AND HOTEL POINTS
Many loyalty programs allow surviving family members to claim points. Contact each program''s bereavement services line. Some programs allow transfer; others do not.',
  ARRAY['digital assets', 'online accounts', 'cryptocurrency', 'social media', 'guide']
),

(
  'How to Transfer or Sell Real Property',
  'Property & Home',
  'guide',
  'HOW TO TRANSFER OR SELL REAL PROPERTY
Guide for Executors and Heirs

OVERVIEW
Real estate is often the largest asset in an estate. How it is transferred depends on how the property was titled and whether probate is required. This guide covers the main transfer methods and the sale process.

HOW PROPERTY MAY BE TITLED
1. Sole ownership: Requires probate. The executor transfers title per the terms of the will.
2. Joint tenancy with right of survivorship: Passes automatically to the surviving owner. File an Affidavit of Survivorship and certified death certificate with the county recorder.
3. Community property (in AZ, CA, ID, LA, NM, NV, TX, WA, WI): Generally passes to the surviving spouse. Specific rules vary by state.
4. Revocable living trust: The successor trustee transfers title without probate per the trust terms.
5. Beneficiary deed / transfer-on-death deed (where available): Property passes directly to the named beneficiary. Record the death certificate with the county.

IF PROBATE IS REQUIRED
1. The property becomes a probate asset. The executor has authority over it under the Letters Testamentary.
2. You must notify the mortgage servicer and continue making payments to protect the estate''s equity.
3. You may need court approval to sell the property, depending on state law.

STEP 1: LOCATE ALL PROPERTY DOCUMENTS
- Original deed (shows how property is titled)
- Mortgage documents and statement
- Title insurance policy
- HOA governing documents and payment records
- Property tax statements
- Home insurance policy

STEP 2: APPRAISE THE PROPERTY
Obtain a certified appraisal for:
- Determining the step-up in cost basis for capital gains tax purposes (the basis "steps up" to fair market value at date of death)
- Setting a realistic sale price
- Required filings with the probate court

STEP 3: MAINTAIN THE PROPERTY
During estate administration, the executor is responsible for:
- Continuing mortgage and HOA payments
- Maintaining property insurance
- Basic upkeep to preserve value

STEP 4: SELLING THE PROPERTY
If heirs agree to sell:
1. Engage a licensed real estate agent experienced in estate sales
2. Obtain court approval if required in your state
3. Complete the sale; proceeds go to the estate account
4. Pay off any mortgage and liens from proceeds
5. Report the sale on the estate''s income tax return (Form 1041) if there is a gain above the stepped-up basis

STEP 5: TRANSFERRING TO A BENEFICIARY
If heirs agree to keep the property:
1. Prepare a deed transferring title from "Estate of [Name]" to the beneficiary
2. Have the deed signed by the executor and notarized
3. Record the deed with the county recorder''s office
4. Transfer insurance and utility accounts to the new owner

TAX CONSIDERATIONS
Property receives a "step-up" in cost basis at the date of death, meaning heirs who sell soon after inheriting generally owe little or no capital gains tax. Consult a CPA for complex situations.',
  ARRAY['real property', 'real estate', 'sale', 'transfer', 'property', 'guide']
),

(
  'How to File the Final Federal Income Tax Return',
  'Government & Benefits',
  'guide',
  'HOW TO FILE THE FINAL FEDERAL INCOME TAX RETURN
Guide for Executors and Surviving Spouses

OVERVIEW
As executor, you are responsible for filing the deceased''s final federal income tax return (Form 1040) and, if the estate earns income, an estate income tax return (Form 1041). This guide explains both.

THE FINAL PERSONAL RETURN (FORM 1040)
Who must file: The executor, on behalf of the deceased.
What it covers: All income from January 1 of the year of death through the date of death.
Filing deadline: Same as normal — April 15 of the following year. Extensions are available (Form 4868).
Write "DECEASED" and the date of death across the top of the return.

JOINT FILING WITH SURVIVING SPOUSE
The surviving spouse may file a joint return with the deceased for the year of death. The surviving spouse signs the return. If another person is the executor, both the surviving spouse and executor must sign.

INCOME TO INCLUDE
- Wages and salary earned through the date of death
- Self-employment income
- Social Security benefits received
- Investment income (dividends, interest, capital gains)
- Retirement distributions received
- Any other income received or constructively received by the date of death

Note: Under the "IRD" (income in respect of a decedent) rules, certain income earned but not yet received at death (final paycheck, deferred compensation, IRA distributions) is taxable income — but reported on the estate return or the beneficiary''s return, not the final 1040.

CLAIMING A REFUND
If a refund is due to the deceased, file Form 1310 (Statement of Person Claiming Refund Due a Deceased Taxpayer) — unless you are the surviving spouse filing jointly, in which case Form 1310 is not required.

ESTATE INCOME TAX RETURN (FORM 1041)
Who must file: The executor, on behalf of the estate.
When required: If the estate earns more than $600 in gross income during administration (interest, dividends, rental income, gains on sale of estate assets, etc.)
Tax year: The estate can choose a fiscal year (e.g., 12 months ending in any month) to allow flexibility in timing.
Get an EIN: The estate must have its own EIN before filing Form 1041.

ESTATE TAX (FORM 706)
Federal estate tax applies only to estates with a gross value exceeding the federal exemption ($13.61 million in 2024, adjusted annually). Very few estates owe federal estate tax. Many states have their own estate or inheritance taxes with lower thresholds — consult a tax professional.

RECOMMEND PROFESSIONAL HELP
Estate tax situations are complex. A CPA or enrolled agent with estate experience is strongly recommended, especially if:
- The estate includes a business
- There is significant investment income
- The estate may owe state estate or inheritance tax
- The deceased had significant deferred compensation or IRD items',
  ARRAY['tax', 'IRS', 'Form 1040', 'Form 1041', 'estate tax', 'guide']
)

ON CONFLICT (name) DO NOTHING;
