-- ============================================================
-- Loss Ally — Phase 3 Content: How-To Instructions for 59 Tasks
-- Source of truth: howto_guide.html in project root
-- Run AFTER supabase-phase3-schema.sql
-- Safe to re-run: updates are idempotent by sort_order
-- ============================================================

-- ── Government & Benefits ─────────────────────────────────────────────────────

UPDATE public.tasks SET
  steps = ARRAY[
    'Call SSA at <strong>1-800-772-1213</strong> (TTY: 1-800-325-0778), Mon–Fri 8am–7pm. Expect hold times of 30–90 minutes — call early.',
    'Have ready: deceased''s full legal name, Social Security number, date of birth, date of death, and your own name and relationship.',
    'Inform SSA of the death. They will flag the account and stop future payments.',
    '<strong>Critical:</strong> Any SSA payment deposited after the date of death must be returned. If direct deposit, SSA will claw it back from the bank automatically. If check, do not cash it — return via mail to the local SSA office.',
    'Ask SSA about <strong>survivor benefits</strong> at this same call: a surviving spouse age 60+ (50+ if disabled), minor children under 18, or dependent parents may qualify.',
    'SSA will mail a confirmation. Keep this for your records.'
  ],
  tip = 'Many banks will automatically return SSA deposits if notified of the death — contact the bank before SSA reaches them to coordinate.',
  warn = 'Cashing or keeping an SSA payment made after the date of death is a federal offense. Return it immediately.',
  states = '[{"state":"All states","detail":"SSA is a federal program with uniform rules. State of residence does not change the process."}]'::jsonb,
  template = 'SSA Death Notification Letter'
WHERE sort_order = 1;

UPDATE public.tasks SET
  steps = ARRAY[
    'Eligibility: surviving spouse age 60+ (any age if caring for deceased''s child under 16), divorced spouse (marriage lasted 10+ years), children under 18 (or 19 if still in high school), disabled children of any age, dependent parents 62+.',
    'Apply at <strong>1-800-772-1213</strong> or in person at your local SSA office. You cannot apply online for survivor benefits.',
    'Documents needed: death certificate, your Social Security number and the deceased''s, marriage certificate (for spouses), birth certificates (for children), proof of citizenship, most recent W-2 or tax return.',
    'Benefit amount is based on the deceased''s earnings record. SSA will calculate and inform you.',
    'A surviving spouse who is full retirement age receives 100% of the deceased''s benefit. Reduced amounts apply for earlier ages.',
    'Lump-sum death payment of <strong>$255</strong> is also available to eligible surviving spouses or dependent children — request this at the same call.'
  ],
  tip = 'If the deceased had recently claimed their own SSA benefits, survivor benefits may be higher than expected if the deceased delayed claiming.',
  states = '[{"state":"Community property states (AZ, CA, ID, LA, NM, NV, TX, WA, WI)","detail":"SSA survivor rules are federal and uniform regardless of community property laws. However, community property may affect how the estate''s assets interact with surviving spouse''s benefits claims.","notable":true}]'::jsonb
WHERE sort_order = 2;

UPDATE public.tasks SET
  steps = ARRAY[
    'The funeral home typically orders death certificates on your behalf — confirm how many they will order and whether you need to request more.',
    'If ordering yourself: contact the <strong>vital records office</strong> of the state where the death occurred (not where the deceased lived). Each state has its own process — most can be ordered online, by mail, or in person.',
    'National online services (VitalChek is the most widely used) can order on your behalf for a convenience fee of $10–20 in addition to the state fee.',
    'Standard fee per certified copy: $5–$25 depending on state. Order generously — you cannot undo having too many, but running out causes real delays.',
    'Quantity guide: 1 for each bank, 1 for each insurance policy, 1 for SSA, 1 for each investment account, 1 for DMV, 1 for probate court, 1 for VA (if applicable), plus 3–5 spares.',
    'Keep all originals in a secure fireproof location. Some institutions will return originals after review; others will not.'
  ],
  tip = 'Order at least 20. Most families under-order and spend weeks waiting for more copies while critical tasks stall.',
  states = '[{"state":"California","detail":"Order from CDPH Vital Records or county registrar. Fee: $21/copy. Online via VitalChek. Processing: 2–3 weeks standard, ~$11 extra for expedited."},{"state":"Texas","detail":"Order from DSHS or county clerk. Fee: $20/copy. Online via VitalChek or txapplication.com. Processing: 10–15 business days."},{"state":"Florida","detail":"Order from FDOH Bureau of Vital Statistics or county health dept. Fee: $10 first copy, $4 each additional. Online via VitalChek."},{"state":"New York","detail":"NYC deaths: NYC Office of Vital Records. All other NY: NYS DOH. Fee: $15/copy. Allow 4–6 weeks by mail; same-day in person at NYC office.","notable":true},{"state":"Illinois","detail":"IDPH Vital Records. Fee: $19/copy. Online via VitalChek. Allow 4–8 weeks for mail orders."},{"state":"Pennsylvania","detail":"PA Dept of Health. Fee: $20/copy. Allow 6–8 weeks by mail. County courthouses may have copies faster for recent deaths.","notable":true}]'::jsonb
WHERE sort_order = 3;

UPDATE public.tasks SET
  steps = ARRAY[
    '<strong>Medicare:</strong> SSA handles Medicare Part A and B — when you notify SSA of the death, Medicare Part A and B are automatically stopped.',
    'However, <strong>Medicare Part D</strong> (prescription drug plan) and <strong>Medicare Advantage</strong> (Part C) are private plans — contact each plan separately to cancel.',
    'Contact number for Medicare: <strong>1-800-MEDICARE</strong> (1-800-633-4227).',
    'Return any unused Medicare cards and request confirmation of cancellation in writing.',
    '<strong>Medicaid:</strong> Contact your state Medicaid office directly (not CMS). Each state administers its own Medicaid program.',
    'Important: Medicaid may have an <strong>estate recovery claim</strong> — in most states, Medicaid can seek repayment from the estate for benefits paid to individuals 55+. Notify your estate attorney immediately if the deceased received Medicaid benefits.',
    'Cancel any Medigap (Medicare Supplement) policies with the private insurer.'
  ],
  warn = 'Medicaid estate recovery can significantly reduce what heirs receive. This claim takes priority over most other estate debts. Do not distribute estate assets until Medicaid claims are resolved.',
  states = '[{"state":"California","detail":"Medi-Cal (CA Medicaid) estate recovery is administered by DHCS. CA has one of the broadest recovery programs — recovers from the full estate, not just probate assets.","notable":true},{"state":"Texas","detail":"TX Medicaid estate recovery is limited to nursing facility services, home/community-based waiver services, and related hospital and prescription drug services for those 55+."},{"state":"New York","detail":"NY does not seek estate recovery from the community spouse''s estate. NY recovery is limited to nursing home Medicaid recipients.","notable":true},{"state":"Florida","detail":"FL estate recovery applies to Medicaid services for individuals 55+ in long-term care. Contact FL AHCA for claim amount."},{"state":"Oregon","detail":"OR has aggressive estate recovery — one of the broadest in the nation. Recovers from the full estate for all Medicaid services to recipients 21+.","notable":true}]'::jsonb,
  template = 'Medicare & Medicaid Notification Letter'
WHERE sort_order = 4;

UPDATE public.tasks SET
  steps = ARRAY[
    'Call the VA at <strong>1-800-827-1000</strong> or visit your nearest VA regional office.',
    '<strong>Burial benefits:</strong> The VA provides burial allowances for eligible veterans. Amount varies by circumstances ($300–$796 for non-service-connected death; $2,000 for service-connected death). Apply within 2 years of burial using VA Form 21P-530.',
    '<strong>Headstone/grave marker:</strong> Apply for a free government headstone or marker for veterans buried in a private cemetery using VA Form 40-1330.',
    '<strong>DIC (Dependency and Indemnity Compensation):</strong> Monthly payment to surviving spouse if veteran died from a service-connected disability, or if veteran had a total disability rating for 10+ continuous years before death. Apply using VA Form 21P-534EZ.',
    '<strong>Survivor''s pension:</strong> Available to surviving spouse of a wartime veteran who meets income and net worth limits. Apply using VA Form 21P-534EZ.',
    'Gather documents: DD-214 (discharge papers), death certificate, marriage certificate, your SSN and financial information.',
    'If you cannot find the DD-214, request a copy from the National Personnel Records Center (archives.gov).'
  ],
  tip = 'The VA process is slow — often 6–12 months. File immediately and request confirmation of receipt. A VA-accredited claims agent (free service) can significantly improve approval rates and speed.',
  states = '[{"state":"All states","detail":"VA benefits are federal. However, many states offer additional state-level veterans benefits including property tax exemptions, additional burial benefits, and state veterans homes. Search your state veterans affairs office for local programs.","notable":true},{"state":"Texas","detail":"Texas Veterans Commission provides free claims assistance. Texas has no state estate tax and significant property tax exemptions for surviving spouses of 100% disabled veterans.","notable":true},{"state":"Florida","detail":"FL Dept of Veterans'' Affairs offers additional homestead property tax exemptions for surviving spouses."}]'::jsonb,
  template = 'VA Survivor Benefits Letter'
WHERE sort_order = 5;

UPDATE public.tasks SET
  steps = ARRAY[
    'Contact your state DMV — most have a specific process for reporting a deceased license holder.',
    'Provide: death certificate, deceased''s license number (if known), full name, and date of birth.',
    'Physically destroy or surrender the physical license if you have it.',
    'Vehicle titles must be transferred separately — the DMV notification of death does not automatically transfer ownership of vehicles.',
    'Request written confirmation of cancellation for your records.'
  ],
  states = '[{"state":"California","detail":"Submit REG 5 form (Notice of Transfer) to DMV. Can be done by mail. CA has a simplified title transfer for surviving spouses without probate via REG 5."},{"state":"Texas","detail":"Report to TX DPS. Vehicle title transfer to heirs can be done via Affidavit of Heirship (Form VTR-262) without probate for vehicles under $10,000.","notable":true},{"state":"Florida","detail":"Notify FL DHSMV. FL allows title transfer to surviving spouse without probate regardless of value.","notable":true},{"state":"New York","detail":"Notify NY DMV via mail with death certificate. NY requires probate or Letters Testamentary for most vehicle title transfers."}]'::jsonb
WHERE sort_order = 6;

UPDATE public.tasks SET
  steps = ARRAY[
    'The final return covers income from January 1 of the year of death through the date of death.',
    'Filing deadline: same as normal — April 15 of the year following death (extensions available via Form 4868).',
    'The executor or administrator is responsible for filing. Write "DECEASED" and the date of death across the top of the return.',
    'If the deceased was married, a joint return may be filed with the surviving spouse for the year of death.',
    'A tax professional (CPA or enrolled agent) is strongly recommended. Estate tax situations are complex.',
    'If a refund is due, file Form 1310 (Statement of Person Claiming Refund Due a Deceased Taxpayer) unless you are the surviving spouse filing jointly.',
    'Final return must include all income up to the date of death: wages, Social Security, investment income, etc.'
  ],
  tip = 'If the deceased made estimated tax payments, these can be credited against any balance due on the final return.',
  exec_note = 'Only the executor or court-appointed administrator can sign and file this return on behalf of the deceased.',
  states = '[{"state":"California","detail":"CA state final return (Form 540) also required, covering same period. CA FTB deadline mirrors federal. CA has no separate inheritance tax."},{"state":"Texas","detail":"TX has no state income tax — no state return required.","notable":true},{"state":"Florida","detail":"FL has no state income tax — no state return required.","notable":true},{"state":"New York","detail":"NY state final return (IT-201) required. NY has an estate tax starting at $7.16M (2024) with a ''cliff'' — estates just above the threshold can face a tax on the full amount, not just the excess.","notable":true},{"state":"Illinois","detail":"IL state final return required. IL estate tax threshold is $4M — significantly lower than federal.","notable":true},{"state":"Oregon","detail":"OR estate tax threshold is $1M — one of the lowest in the nation. OR income tax return also required.","notable":true},{"state":"Massachusetts","detail":"MA estate tax threshold is $2M. MA also requires a final state income tax return.","notable":true},{"state":"Washington State","detail":"WA has no state income tax but has an estate tax starting at $2.193M (2024). WA is also a community property state.","notable":true}]'::jsonb
WHERE sort_order = 7;

UPDATE public.tasks SET
  steps = ARRAY[
    'An EIN is required if: the estate goes through probate, the estate earns any income after death (interest, rent, dividends), or an estate bank account is needed.',
    'Apply free at <strong>IRS.gov/EIN</strong> — the online application takes about 5 minutes and the EIN is issued immediately.',
    'You will need: the executor''s name and SSN, deceased''s name and SSN, date of death, and the estate''s legal name ("Estate of [Full Name]").',
    'Select "Estate" as the entity type on the application.',
    'Keep the EIN confirmation letter (CP 575) — you will need this number for opening estate bank accounts and filing estate tax returns.'
  ],
  exec_note = 'Only the executor can apply for the estate EIN, as they are responsible for the estate''s tax obligations.',
  states = '[{"state":"All states","detail":"EIN application is federal (IRS) and uniform across all states."}]'::jsonb
WHERE sort_order = 8;

UPDATE public.tasks SET
  steps = ARRAY[
    'Form 1041 covers income the estate itself earns after death: interest, dividends, rental income, business income.',
    'Required if gross income is $600 or more, or if any beneficiary is a nonresident alien.',
    'Fiscal year can be chosen (vs. calendar year) — can offer tax planning opportunities.',
    'Deductions available: executor fees, attorney fees, accounting fees, and certain administration expenses.',
    'A CPA experienced in estate taxation should prepare this return.',
    'Deadline: 15th day of the 4th month after the estate''s fiscal year ends.'
  ],
  exec_note = 'Executor signs Form 1041 as the fiduciary responsible for the estate.',
  states = '[{"state":"Most states","detail":"States with income tax require a separate state fiduciary income tax return, typically due on the same schedule as the federal return."},{"state":"California","detail":"CA Form 541 (Fiduciary Income Tax Return) required if estate has CA source income."},{"state":"New York","detail":"NY Form IT-205 required."}]'::jsonb
WHERE sort_order = 9;

-- ── Legal & Probate ───────────────────────────────────────────────────────────

UPDATE public.tasks SET
  steps = ARRAY[
    'Check the deceased''s home files and personal safe — look for a folder labeled "Important Documents," "Estate," or "Legal."',
    'Check any bank safe deposit boxes. Note: you may need Letters Testamentary to access the box, but many states allow access just to retrieve a will. Bring the death certificate and your ID.',
    'Contact their estate attorney — attorneys typically hold the original will for clients.',
    'Check with the county probate court — some individuals file their will with the court during their lifetime.',
    'Search home thoroughly: filing cabinets, fireproof boxes, desk drawers, and even stored boxes.',
    'If the will cannot be found: most states allow a copy or a reconstructed will to be admitted if witnesses can attest to its contents, but this is complex and requires legal counsel.',
    'Secure the will immediately — do not let any interested party (especially a potential beneficiary) possess it unsupervised.'
  ],
  warn = 'Never alter, destroy, or conceal a will — this is a crime in all 50 states.',
  states = '[{"state":"Most states","detail":"A lost will creates a presumption that it was revoked by the testator. This presumption can be rebutted but requires significant evidence and legal proceedings.","notable":true},{"state":"California","detail":"CA Probate Code Section 6124 creates a rebuttable presumption that a missing will was revoked. CA does allow admission of a copy if the proponent can establish the will''s terms and that the original was not revoked.","notable":true},{"state":"Texas","detail":"TX allows a copy of a lost will to be probated if two witnesses can testify it was not revoked. Strongly recommend an attorney.","notable":true}]'::jsonb
WHERE sort_order = 10;

UPDATE public.tasks SET
  steps = ARRAY[
    'Assets that <strong>avoid probate entirely</strong> (regardless of state): joint tenancy assets (pass to surviving owner), assets with named beneficiaries (life insurance, retirement accounts, POD/TOD accounts), assets held in a living trust.',
    'Assets that typically <strong>require probate</strong>: individually owned real property, bank accounts in the deceased''s name only with no beneficiary designation, personal property over state thresholds.',
    'If the estate consists entirely of non-probate assets, no court involvement is needed.',
    'If probate is required, consult an estate attorney in the state where the deceased resided (the domicile state).',
    'If the deceased owned real property in multiple states, <strong>ancillary probate</strong> may be required in each state where property is located.',
    'Many states have simplified procedures for small estates — check your state''s threshold.'
  ],
  tip = 'A living trust, if properly funded, avoids probate entirely and is often the most efficient estate plan. If one exists, work with the trustee rather than through probate court.',
  states = '[{"state":"California","detail":"CA probate threshold: $184,500 (2022, adjusts periodically). Below this, a simple Affidavit (Probate Code 13100) can be used. Probate above this threshold is slow (18–24 months) and expensive (attorney fees are statutory: ~4% on first $100K, scaling down).","notable":true},{"state":"Texas","detail":"TX $75,000 threshold for muniment of title (simplified process). TX has efficient Independent Administration which avoids most court supervision.","notable":true},{"state":"Florida","detail":"FL $75,000 threshold for summary administration. FL also has disposition without administration for very small estates. Standard FL probate is relatively efficient.","notable":true},{"state":"New York","detail":"NY small estate threshold: $50,000. NY Surrogate''s Court handles probate — can be slow in NYC. NY allows voluntary administration for estates under $50K.","notable":true},{"state":"Illinois","detail":"IL small estate threshold: $100,000. IL probate is handled in county Circuit Courts."},{"state":"Wisconsin","detail":"WI is a community property state with a marital property agreement system — surviving spouses can transfer community property with a simple affidavit in many cases.","notable":true}]'::jsonb
WHERE sort_order = 11;

UPDATE public.tasks SET
  steps = ARRAY[
    'Hire an estate attorney in the state of domicile — probate filings vary significantly by county court and state statute.',
    'File a petition to admit the will to probate and for appointment of executor (or administrator if no will) with the appropriate court: Probate Court, Surrogate''s Court, or Circuit Court depending on state.',
    'File the original will and a certified death certificate with the petition.',
    'The court sets a hearing date (typically 2–8 weeks out). In most states, all heirs and beneficiaries must be notified of the hearing.',
    'At the hearing, the court admits the will and formally appoints the executor.',
    'The court issues <strong>Letters Testamentary</strong> (if will exists) or <strong>Letters of Administration</strong> (if no will). These are the documents that give you legal authority to act.',
    'Most courts charge a filing fee of $50–$400 depending on estate value and state.'
  ],
  exec_note = 'Only the named executor (or proposed administrator) can file the petition and be appointed by the court.',
  states = '[{"state":"California","detail":"File in Superior Court, Probate Division, of the county where deceased resided. Statutory notice period: 15–30 days. Publication of notice required. Full probate typically takes 18–24 months.","notable":true},{"state":"Texas","detail":"File in the county Probate Court (or District Court if no Probate Court). TX favors Independent Administration — once appointed, executor acts without ongoing court approval.","notable":true},{"state":"Florida","detail":"File in Circuit Court in the county of domicile. FL has Formal and Summary Administration. Formal administration typically takes 6–12 months."},{"state":"New York","detail":"File in Surrogate''s Court in the county of domicile. NYC Surrogate''s Court can be slow. NY requires an attorney for most probate proceedings.","notable":true},{"state":"Pennsylvania","detail":"File in the Register of Wills in the county of domicile. PA has a relatively streamlined probate process."},{"state":"Michigan","detail":"MI has a relatively straightforward probate process with Independent Administration available. File in Probate Court in county of residence."}]'::jsonb,
  template = 'Probate Petition Cover Letter'
WHERE sort_order = 12;

UPDATE public.tasks SET
  steps = ARRAY[
    'Letters Testamentary are issued when a will names an executor. Letters of Administration are issued when there is no will (intestate) or the named executor cannot serve.',
    'Request multiple certified copies — typically 10–15. Each institution will require its own original certified copy.',
    'Cost: typically $5–$20 per certified copy, paid to the court.',
    'Letters have an expiration date in some states — check and renew if needed for long administrations.',
    'Present Letters Testamentary when: opening estate bank accounts, accessing individual financial accounts, signing real estate documents, filing court papers, or dealing with any institution that requires executor authority.'
  ],
  exec_note = 'Only the appointed executor can possess and use Letters Testamentary. These documents prove your legal authority.',
  states = '[{"state":"California","detail":"CA Letters do not expire but some institutions may question Letters older than 6 months. You can obtain updated Letters from the court at minimal cost."},{"state":"Texas","detail":"TX Letters expire after 4 years from issuance. Renew if needed.","notable":true},{"state":"Florida","detail":"FL Letters remain valid until the estate is closed."},{"state":"New York","detail":"NY Letters expire at the discretion of the court — check the expiration date on your Letters.","notable":true}]'::jsonb
WHERE sort_order = 13;

UPDATE public.tasks SET
  steps = ARRAY[
    'Identify all beneficiaries named in the will and all legal heirs (those who would inherit under state intestacy laws).',
    'Send formal written notice by certified mail with return receipt requested — this creates a legal record.',
    'Notice must typically include: name of deceased, date of death, name of executor, where the will was filed, and a statement of the right to contest.',
    'Deadline for notice: varies by state — typically within 30–60 days of being appointed executor.',
    'Keep signed return receipts as proof of notification.',
    'If a beneficiary cannot be located: consult your attorney. Many states allow publication as alternative notice after diligent search.'
  ],
  exec_note = 'The executor is personally responsible for proper notification. Failure to notify can expose the executor to personal liability.',
  states = '[{"state":"California","detail":"Notice must be sent within 30 days of appointment. All known heirs and beneficiaries must receive Notice of Petition to Administer Estate."},{"state":"Texas","detail":"TX requires notice to all beneficiaries within a reasonable time. Intestate heirs must be identified and notified even if no will."},{"state":"Florida","detail":"FL requires service of a Notice of Administration on all interested persons within 3 months of the appointment.","notable":true}]'::jsonb,
  template = 'Beneficiary Notification Letter'
WHERE sort_order = 14;

UPDATE public.tasks SET
  steps = ARRAY[
    'List all assets in three categories: (1) probate assets (owned individually, no beneficiary), (2) non-probate assets (joint tenancy, beneficiary designations, trust assets), (3) personal property.',
    'For financial accounts: gather the most recent statements for all accounts.',
    'For real property: obtain a property appraisal or tax assessment as of the date of death.',
    'For personal property of significant value (art, jewelry, vehicles, collectibles): obtain certified appraisals.',
    'For business interests: obtain a business valuation from a qualified appraiser.',
    'For digital assets: document all accounts, their contents, and estimated value.',
    'Many courts require a formal inventory (with values as of the date of death) to be filed within 60–90 days of appointment.',
    'This inventory becomes the basis for the estate tax return if applicable.'
  ],
  exec_note = 'The executor signs and files the inventory with the probate court. This is a formal legal document.',
  states = '[{"state":"California","detail":"CA does not require a formal inventory filing with the court in most cases, but one must be prepared for the executor''s records and for tax purposes."},{"state":"Texas","detail":"TX requires an inventory, appraisement, and list of claims to be filed with the court within 90 days of appointment.","notable":true},{"state":"Florida","detail":"FL requires filing an inventory within 60 days of appointment.","notable":true},{"state":"New York","detail":"NY may require filing a detailed inventory depending on the type of administration."}]'::jsonb
WHERE sort_order = 15;

UPDATE public.tasks SET
  steps = ARRAY[
    'Distributions can only be made after: all creditor claim periods have expired, all known debts and taxes are paid, all estate expenses are paid.',
    'Follow the will''s instructions exactly. Any deviation can expose the executor to personal liability.',
    'For cash distributions: transfer from the estate bank account with full documentation.',
    'For real property: executor signs and records a deed transferring title to the heir.',
    'For personal property: create a receipt signed by each heir acknowledging receipt of specific items.',
    'For retirement accounts and life insurance: these typically pass directly to named beneficiaries outside this process.',
    'Obtain a signed <strong>Receipt and Release</strong> from each heir acknowledging full satisfaction of their interest.',
    'Maintain complete records of all distributions for the final estate accounting.',
    'In formal probate: file a petition for final distribution and obtain court approval before distributing.'
  ],
  exec_note = 'The executor is personally liable for improper distributions. Never distribute before all debts and taxes are settled.',
  warn = 'If the executor distributes assets and a creditor later presents a valid claim, the executor may be personally responsible for paying it.',
  states = '[{"state":"Texas","detail":"TX Independent Administration allows the executor to make distributions without court approval after notifying creditors and paying debts.","notable":true},{"state":"California","detail":"CA typically requires court approval for final distributions — a petition for final distribution must be filed and a hearing held.","notable":true}]'::jsonb
WHERE sort_order = 16;

-- ── Financial Accounts ────────────────────────────────────────────────────────

UPDATE public.tasks SET
  steps = ARRAY[
    'Review the deceased''s mail (physical and email) for statements, bill notifications, and account confirmations.',
    'Check the most recent 2–3 years of federal tax returns — interest and dividend income (Schedule B) will reveal most investment and bank accounts.',
    'Check for a password manager (1Password, Bitwarden, LastPass, Keychain) — may contain logins to financial institutions.',
    'Review bank statements for direct deposits (reveals income sources) and recurring withdrawals (reveals loan payments, insurers, investment accounts).',
    'Search email for keywords: "statement," "account," "portfolio," "e-delivery," "quarterly statement."',
    'Check physical files for account paperwork, brokerage confirmations, and insurance policies.',
    'Contact HR department of the last employer — group life insurance, 401(k), pension, and stock plans may not be known to the family.',
    'Use the <strong>NAUPA unclaimed property database</strong> (missingmoney.com) to check for forgotten accounts.'
  ],
  tip = 'The most common overlooked accounts: old 401(k) from a previous employer, small savings accounts, whole life insurance policies purchased decades ago, and savings bonds.'
WHERE sort_order = 17;

UPDATE public.tasks SET
  steps = ARRAY[
    'Identify all automatic payments from bank statements — subscriptions, insurance, utilities, loan payments, memberships.',
    'For each auto-draft: contact the merchant directly to cancel or put on hold. Explain the account holder has passed away.',
    'For credit card auto-pay: do not cancel credit cards before cancelling everything that auto-bills to them.',
    'Keep track of which services have been cancelled vs. which need to continue (mortgage payments must continue until property is sold or transferred).',
    'For services that must continue (utilities at an occupied home, mortgage), arrange for payment from the estate account rather than the deceased''s personal account.',
    'Contact the bank and flag the account to block new ACH debits while allowing existing commitments to be reviewed.'
  ],
  tip = 'A spreadsheet tracking every auto-payment — merchant, amount, cancellation status — prevents both missed cancellations and accidentally cutting off essential services.'
WHERE sort_order = 18;

UPDATE public.tasks SET
  steps = ARRAY[
    'Call the customer service number on the back of each card or statement. Ask to speak with the <strong>Estate Services</strong> or <strong>Bereavement</strong> team — these specialists handle this more effectively than general CSRs.',
    'Provide: death certificate, the executor''s name and contact information, and Letters Testamentary (if available).',
    '<strong>Joint accounts:</strong> The surviving owner retains full access. Notify the bank to remove the deceased''s name from the account.',
    '<strong>Individual accounts:</strong> The bank will freeze the account pending executor authority. The executor can access funds to pay estate expenses once Letters Testamentary are presented.',
    '<strong>POD (Payable on Death) accounts:</strong> The named beneficiary can claim directly with a death certificate — no probate required.',
    'Request a statement showing the account balance as of the date of death — needed for estate inventory.',
    'Close accounts after all funds are transferred to the estate account (or to beneficiaries for POD accounts).'
  ],
  states = '[{"state":"Community property states (AZ, CA, ID, LA, NM, NV, TX, WA, WI)","detail":"Accounts held as community property vest automatically in the surviving spouse — but the bank still needs to be notified and documentation updated.","notable":true},{"state":"All states","detail":"The FDIC insures individual accounts up to $250,000. Joint accounts may be insured up to $250,000 per co-owner."}]'::jsonb,
  template = 'Financial Institution Notification Letter'
WHERE sort_order = 19;

UPDATE public.tasks SET
  steps = ARRAY[
    'Call the number on the back of each card. Ask for the bereavement or estate department.',
    'Provide the deceased''s name, account number, and date of death. A death certificate will typically be required.',
    'Request a final statement showing the balance due as of the date of death.',
    'Debts on individual credit cards are estate debts — they must be paid from estate assets before distribution to heirs. Heirs do not personally inherit credit card debt.',
    'For joint cards: the surviving cardholder remains fully liable for the balance. Continue paying to avoid credit damage.',
    'Authorized users (not joint cardholders) on the deceased''s card: cancel all authorized user cards. Authorized users have no liability for the balance.',
    'Review final statements for any fraudulent charges made after death.'
  ],
  warn = 'Do not let anyone convince you that you are personally responsible for the deceased''s individual credit card debt. You are not — unless you were a joint account holder (not just an authorized user).',
  template = 'Credit Card Company Notification Letter'
WHERE sort_order = 20;

UPDATE public.tasks SET
  steps = ARRAY[
    'Locate all policies: individual life insurance, employer group life, accidental death, mortgage life insurance, credit life insurance on loans.',
    'Call each insurer''s claims department. Request a certified claim form.',
    'Submit: completed claim form, certified death certificate, and the original policy (if required — some insurers only need the policy number).',
    'The insurer has 30 days in most states to pay a valid claim after receiving complete documentation.',
    'Payment options: lump sum (most common), installments, or retained asset account. Lump sum is generally recommended.',
    'If no beneficiary is named or the beneficiary predeceased the insured: the death benefit typically goes to the estate and becomes a probate asset.',
    'For employer group life insurance: contact HR for the carrier''s name and policy information.',
    'VGLI (Veterans Group Life Insurance): separate process through OSGLI at 1-800-419-1473.'
  ],
  tip = 'Accelerated death benefits (ADB) paid before death due to terminal illness may reduce the death benefit. Request a complete statement from the insurer showing any ADB advances.',
  states = '[{"state":"Most states","detail":"Insurers must pay within 30–45 days of receiving a complete claim. If payment is delayed without valid reason, most states require the insurer to pay interest."},{"state":"California","detail":"CA Insurance Code requires payment within 30 days of proof of death. Interest accrues if delayed."},{"state":"Florida","detail":"FL requires payment within 30 days. Delayed payment incurs interest at 8% per year.","notable":true},{"state":"Texas","detail":"TX requires payment within 15 days of receiving all required information.","notable":true}]'::jsonb,
  template = 'Life Insurance Claim Letter'
WHERE sort_order = 21;

UPDATE public.tasks SET
  steps = ARRAY[
    'Locate pension information: employer HR files, annual statements, retirement plan documentation.',
    'Contact the plan administrator (HR for employer plans; separate administrator for union plans).',
    'Provide: death certificate, your relationship to the deceased, and the deceased''s employee ID or plan number.',
    'Ask specifically about: survivor annuity options, pre-retirement death benefits, and any lump sum options.',
    'For a joint-and-survivor annuity elected before retirement: the surviving spouse receives a percentage (typically 50–100%) of the benefit for life.',
    'If the employee died before retirement: a pre-retirement survivor benefit may be payable. Terms vary significantly by plan.',
    'Federal employees: contact the Office of Personnel Management (OPM) at 1-888-767-6738 for CSRS or FERS survivor benefits.',
    'Request a copy of the Summary Plan Description (SPD) if you don''t have it — this explains all benefits in plain language.'
  ],
  warn = 'Some pension elections made at retirement eliminate survivor benefits in exchange for a higher monthly payment. Review the retirement election documents carefully — there may be no survivor benefit.',
  template = 'Pension Administrator Notification Letter'
WHERE sort_order = 22;

UPDATE public.tasks SET
  steps = ARRAY[
    'Contact Fidelity, Vanguard, Schwab, Merrill, or whichever institution holds the account.',
    'Ask for the beneficiary designation on file — this determines who receives the assets.',
    '<strong>Spouse beneficiary:</strong> Can roll over the account into their own IRA (most tax-efficient) or take distributions under the inherited IRA rules.',
    '<strong>Non-spouse beneficiary:</strong> Must open an Inherited IRA. Under the SECURE 2.0 Act (2022), most non-spouse beneficiaries must fully distribute the account within 10 years.',
    '<strong>No beneficiary named or beneficiary predeceased:</strong> Account goes to the estate (or per plan default rules). This makes it a probate asset and loses the tax-advantaged transfer.',
    'For inherited IRAs: advise the beneficiary to consult a financial advisor before taking distributions — the tax implications are significant.',
    'Required documents: death certificate, completed beneficiary claim form, and beneficiary''s ID.'
  ],
  warn = 'Never roll a deceased spouse''s 401(k) or IRA into your own account directly — you must roll it into an "Inherited IRA" first (or elect direct rollover). Taking a direct distribution triggers immediate taxation on the full amount.',
  states = '[{"state":"Community property states (AZ, CA, ID, LA, NM, NV, TX, WA, WI)","detail":"In community property states, the non-owner spouse may have a community property interest in the retirement account regardless of the beneficiary designation. Consult an attorney before processing claims.","notable":true}]'::jsonb
WHERE sort_order = 23;

UPDATE public.tasks SET
  steps = ARRAY[
    'Contact the brokerage''s estate services or transfer-on-death department.',
    '<strong>TOD (Transfer on Death) accounts:</strong> The named beneficiary presents a death certificate and account information — assets transfer directly without probate.',
    '<strong>Joint tenancy with right of survivorship:</strong> Surviving owner provides death certificate; their name becomes the sole owner.',
    '<strong>Individual accounts without TOD:</strong> Require Letters Testamentary. The executor can direct the transfer or sale of assets.',
    'Do not sell assets immediately without understanding the tax implications — assets receive a <strong>stepped-up cost basis</strong> to the date-of-death value, which can eliminate significant capital gains.',
    'Request a statement showing all holdings and their fair market value as of the date of death — needed for estate inventory and tax filings.',
    'If assets are to be distributed in kind (as securities, not cash) to heirs, the brokerage can facilitate an in-kind transfer to beneficiary accounts.'
  ],
  tip = 'The stepped-up cost basis is one of the most significant tax benefits of inherited assets. A stock bought for $10 that was worth $100 at death has a new basis of $100 — the $90 gain disappears for tax purposes.'
WHERE sort_order = 24;

-- ── Property & Home ───────────────────────────────────────────────────────────

UPDATE public.tasks SET
  steps = ARRAY[
    'Confirm all doors and windows are locked. Change the locks if keys were given to anyone outside the immediate family.',
    'If the deceased had a home security system: change the access code and update the account contacts with the monitoring company.',
    'Contact the homeowner''s or renter''s insurance company immediately — vacancy status can affect coverage.',
    'Walk through the property and document its condition with photos and video — timestamped — to protect against any later claims of damage.',
    'If the home will be vacant: visit or arrange for someone to check in at least weekly. A vacant home invites problems — pipes, pests, break-ins.',
    'Collect any spare keys held by neighbors, caregivers, or service providers.',
    'Retrieve any vehicles on the property — secure them in a locked garage or notify insurance.'
  ],
  warn = 'Many homeowner''s policies limit or exclude coverage after 30–60 days of vacancy. Call the insurer before this threshold.'
WHERE sort_order = 25;

UPDATE public.tasks SET
  steps = ARRAY[
    'Set up mail forwarding at <strong>USPS.com</strong> or at any post office. Cost: $1.10 identity verification fee online.',
    'Forwarding lasts up to 12 months for First-Class mail. Premium mail forwarding (additional fee) extends this and includes some package classes.',
    'Set up forwarding to the executor''s address — not to any individual heir who may be in conflict with others.',
    'Watch mail carefully: creditors, courts, government agencies, and financial institutions communicate by mail.',
    'Set up a physical inbox or folder system to track and date-stamp incoming mail.',
    'Also review the deceased''s email account (if accessible) for electronic bills, statements, and notifications.'
  ]
WHERE sort_order = 26;

UPDATE public.tasks SET
  steps = ARRAY[
    'Contact the landlord or property management company in writing (and by phone). Provide a certified death certificate.',
    'Review the lease for any provisions about death — some leases have explicit death clauses.',
    'Ask about termination: when is the last day you are obligated to pay rent? When must the property be vacated?',
    'Request a walk-through and document the property''s condition before returning keys.',
    'Retrieve the security deposit per state law — the landlord must return it within the statutory period.',
    'Remove all personal property promptly — landlords cannot hold or dispose of a deceased tenant''s belongings without following state abandoned property laws.'
  ],
  states = '[{"state":"California","detail":"CA Civil Code Section 1934 allows the estate to terminate a lease with 30 days written notice after the tenant''s death.","notable":true},{"state":"Texas","detail":"TX Property Code allows the executor to terminate the lease with 30 days written notice.","notable":true},{"state":"Florida","detail":"FL Statutes provide that a lease terminates automatically at death if the deceased was the sole tenant, with proper notice.","notable":true},{"state":"New York","detail":"NY allows the estate to terminate with notice — typically 30 days per the lease terms."},{"state":"Illinois","detail":"IL allows early lease termination upon death with 2 months'' written notice.","notable":true}]'::jsonb,
  template = 'Landlord Death Notification Letter'
WHERE sort_order = 27;

UPDATE public.tasks SET
  steps = ARRAY[
    'Make a list of all utilities: electric, gas, water/sewer, internet, cable/streaming, landline phone.',
    '<strong>If property will continue to be occupied:</strong> Transfer each utility account to the heir, trust, or estate name. Call each provider, explain the situation, and request a transfer. You may need to provide a death certificate.',
    '<strong>If property will be vacated or sold:</strong> Cancel each utility effective the date of vacancy — but keep electric and minimal heat on until the property transfers if weather requires it.',
    'For internet/cable: check for contract termination fees. Most providers waive these upon proof of death.',
    'Keep utilities connected through any estate sale or property showing — buyers expect a functioning home.',
    'Gas and electric: request a final meter read for accurate billing on the closing date.'
  ]
WHERE sort_order = 28;

UPDATE public.tasks SET
  steps = ARRAY[
    'Contact the mortgage servicer (the company you send payments to, not necessarily the original lender).',
    'Provide a death certificate and explain who you are. Request to speak with the loss mitigation or bereavement department.',
    'If the deceased was the sole borrower and there is a surviving occupant: the servicer may offer options, including assumption of the loan.',
    'If there is a surviving co-borrower (e.g., spouse): they remain fully responsible for the mortgage and payments should continue uninterrupted.',
    'Check whether a mortgage life insurance policy exists — this would pay off the remaining balance.',
    'The <strong>Garn-St Germain Act</strong> (federal law) prevents lenders from calling the full loan due when a property passes to a family member — the heir can assume and continue the mortgage without refinancing.',
    'Request a current payoff statement — needed if the property will be sold.'
  ],
  exec_note = 'Decisions about selling or refinancing the mortgaged property require the executor''s authority.',
  states = '[{"state":"All states","detail":"Federal law (Garn-St Germain Act) governs mortgage assumptions upon death uniformly across all states. A surviving heir who inherits the property has the right to assume and continue the mortgage.","notable":true}]'::jsonb,
  template = 'Mortgage Servicer Notification Letter'
WHERE sort_order = 29;

UPDATE public.tasks SET
  steps = ARRAY[
    'Locate the lease agreement in the deceased''s files, email inbox, or the vehicle''s glove compartment. The lessor''s contact number is printed on the agreement and on any monthly billing statement.',
    'Call the lessor and ask for the <strong>estate services or bereavement department</strong>. Provide the deceased''s name, account number, and date of death.',
    'Request the early termination provisions for death of lessee. Major lessors have formal death clauses that typically <strong>waive the early termination fee entirely</strong> — but this is not automatic. You must invoke it with documentation.',
    'Documents you will typically need: certified death certificate, Letters Testamentary (confirming your executor authority), your government-issued photo ID, and a written termination request.',
    'Ask the lessor directly: "Will you waive the early termination fee under your death of lessee clause?" Get this confirmed in writing.',
    '<strong>Do not continue making lease payments</strong> after submitting termination paperwork unless the lessor specifically instructs you to continue in writing while they process the request.',
    'When returning the vehicle, request a written confirmation documenting the return date, mileage at surrender, and vehicle condition.',
    'Check whether the lease included <strong>GAP insurance</strong>. If the vehicle was totaled in an accident near the time of death, GAP coverage pays the difference between the insurance payout and the remaining lease obligation.',
    'If payments were being auto-drafted from the deceased''s bank account, notify the bank to stop the draft — but only after the lessor confirms termination is accepted.',
    'Once the account is closed and zero balance confirmed, get a written closing letter. Keep this document for 7 years.'
  ],
  tip = 'Unsure whether the vehicle was leased or owned? Check the glove compartment for a title (owned) or a lease agreement (leased). If neither is present, contact the auto insurer — they will know which it is.',
  warn = 'Do not surrender the vehicle without getting written confirmation of the return and a zero-balance letter. Without documentation, the lessor could later claim damage or unpaid amounts.',
  states = '[{"state":"All states","detail":"Lease agreements are governed by state contract law, but the death clause process is set by the individual lessor. Some states (notably California) have consumer protection laws that limit what a lessor can charge after a lessee''s death."}]'::jsonb,
  template = 'Vehicle Lease Termination Letter'
WHERE sort_order = 30;

UPDATE public.tasks SET
  steps = ARRAY[
    '<strong>For real property:</strong> The executor signs a deed (typically an "Executor''s Deed" or "Administrator''s Deed") conveying the property to the heir or buyer.',
    'The deed must be notarized and recorded with the county recorder/register of deeds in the county where the property is located.',
    'If the property is subject to a mortgage, the lender must be notified of the transfer.',
    'If the property was held in joint tenancy: the surviving tenant records an Affidavit of Death of Joint Tenant (with a certified death certificate attached) — no probate needed.',
    '<strong>For vehicles:</strong> Contact the state DMV for the transfer process. Requirements vary by state.',
    'Inherited vehicles may qualify for exemption from sales tax in many states.',
    'If a vehicle has a loan, contact the lender — the loan typically must be paid off or assumed.'
  ],
  exec_note = 'Only the executor can sign the deed transferring real property from the estate. This is non-delegable.',
  states = '[{"state":"California","detail":"CA allows a simplified transfer of real property for estates under $184,500 using a Petition to Determine Succession to Real Property. Otherwise, executor''s deed after probate. CA REQUIRES court confirmation for most real estate sales by the estate.","notable":true},{"state":"Texas","detail":"TX Muniment of Title is a simplified process to transfer title using just the will without full administration. For intestate, an Affidavit of Heirship recorded at the county clerk can transfer title without probate.","notable":true},{"state":"Florida","detail":"FL allows use of a Lady Bird Deed (Enhanced Life Estate Deed) to avoid probate for real estate — but this must have been set up before death. Otherwise, executor''s deed through formal administration.","notable":true}]'::jsonb
WHERE sort_order = 31;

-- ── Digital Estate ────────────────────────────────────────────────────────────

UPDATE public.tasks SET
  steps = ARRAY[
    'Go to <strong>facebook.com/special/remember</strong> to submit a memorialization or removal request.',
    'For <strong>memorialization:</strong> The profile is preserved, marked "Remembering," and cannot be logged into. Friends can still post on the timeline. A legacy contact (if the deceased designated one) can manage limited aspects.',
    'For <strong>removal:</strong> Submit a removal request with proof of death (death certificate) and your relationship to the deceased.',
    'Instagram: submit via <strong>help.instagram.com</strong> — search for "deceased." Instagram allows memorialization or removal.',
    'Meta requires: name of deceased, URL of the profile, and either the deceased''s email or proof of death.',
    'Processing time: typically 1–4 weeks.',
    'After memorialization, the account does not appear in ads or "people you may know" — this prevents distressing reminders for friends.'
  ]
WHERE sort_order = 32;

UPDATE public.tasks SET
  steps = ARRAY[
    '<strong>Gmail (Google):</strong> Google''s Inactive Account Manager may have designated a trusted contact. If not, a family member can submit a request via google.com/accounts/answer/6357590. Google may provide account content or close the account on a case-by-case basis.',
    '<strong>Outlook (Microsoft):</strong> A "next of kin" process is available. Microsoft will provide a DVD of the deceased''s account content (emails) after a formal request and proof of death.',
    '<strong>Yahoo:</strong> Yahoo does not transfer accounts but will close the account with proof of death.',
    '<strong>Before closing:</strong> If you can access the account (have the password), download or forward any important emails — especially financial statements, insurance documents, and correspondence with attorneys or advisors.',
    'Set up an auto-reply on any accessible email to inform incoming senders of the death and provide the executor''s contact information.'
  ],
  tip = 'If you cannot access the email account and there are important documents within it, contact the email provider before attempting to guess passwords — unauthorized access to email accounts is a federal crime (Computer Fraud and Abuse Act) even for family members.'
WHERE sort_order = 33;

UPDATE public.tasks SET
  steps = ARRAY[
    'Build a list from bank and credit card statements: look for recurring charges from Netflix, Spotify, Hulu, Amazon Prime, Disney+, Apple One, Adobe Creative Cloud, Microsoft 365, Audible, Kindle Unlimited, LinkedIn Premium, news outlets, etc.',
    '<strong>Netflix:</strong> Log into account (if you have the password) and cancel under Account > Cancel Membership. Or contact Netflix support with a death certificate.',
    '<strong>Spotify:</strong> Cancel online or contact spotify.com/account/subscription. Request a refund of prepaid amounts.',
    '<strong>Amazon Prime:</strong> Log in and cancel at amazon.com/prime. Or contact Amazon support. Amazon may refund unused portion.',
    '<strong>Apple subscriptions (App Store):</strong> Requires access to the Apple ID — see Apple ID task. Cancel via Settings > [Name] > Subscriptions.',
    'For any subscription you cannot cancel online due to lack of password: call the service with a death certificate. Most services will cancel and refund immediately.',
    'After cancelling all subscriptions, contact the credit card company to flag any new charges from the same merchants — some subscriptions silently restart.'
  ]
WHERE sort_order = 34;

UPDATE public.tasks SET
  steps = ARRAY[
    'Apple Digital Legacy (introduced iOS 15.2): if the deceased set up a Legacy Contact, that person can access most iCloud data including photos, messages, notes, and files using their Apple ID and a special access key.',
    'If no Legacy Contact was set up: Apple requires a court order granting access to the account. This is a complex legal process — consult an attorney.',
    'Submit a request to Apple''s Digital Legacy team at <strong>apple.com/legal/privacy/data/en/digital-legacy</strong>.',
    'If you have the device password and the deceased''s Apple ID credentials: you can access content directly on the device. Back up photos and important files to an external drive before the account is closed.',
    'Apple ID accounts cannot be transferred or inherited — once closed, access is permanently lost.',
    'iCloud Family Sharing: if the deceased was the Family Organizer, shared subscriptions and purchased content may be affected. Update the Family Sharing account.'
  ],
  warn = 'Do not factory reset or wipe any of the deceased''s devices until you are certain you have retrieved all important data (photos, contacts, notes, messages, documents).'
WHERE sort_order = 35;

UPDATE public.tasks SET
  steps = ARRAY[
    'Search for hardware wallets (Ledger, Trezor) — physical devices, often resembling a USB drive.',
    'Search for written seed phrases (12 or 24 words) — often stored in physical form, sometimes in a safe or with estate documents.',
    'Search for accounts at crypto exchanges: Coinbase, Kraken, Binance, Gemini, Robinhood, etc.',
    'Check for software wallets: MetaMask, Exodus, Trust Wallet — these are apps on the deceased''s phone or computer.',
    'For exchange accounts: contact the exchange with a death certificate and Letters Testamentary. Coinbase, Kraken, and most major exchanges have estate claim processes.',
    'For hardware wallets with a seed phrase: consult a cryptocurrency specialist before attempting recovery — improper attempts can permanently lock the wallet.',
    'If no seed phrase can be found for a hardware wallet: the funds may be permanently inaccessible. Cryptocurrency recovery services exist but results are not guaranteed.',
    'Document all crypto holdings and their fair market value as of the date of death — required for estate tax filings.'
  ],
  warn = 'NEVER share seed phrases with recovery services or online tools you do not fully trust. Crypto theft using seed phrases is common.'
WHERE sort_order = 36;

UPDATE public.tasks SET
  steps = ARRAY[
    '<strong>American Airlines AAdvantage:</strong> Miles can be transferred to a family member or donated to charity. Call 1-800-882-8880 with death certificate.',
    '<strong>Delta SkyMiles:</strong> Miles can be transferred to surviving family members. Call 1-800-323-2323.',
    '<strong>United MileagePlus:</strong> Miles transfer to beneficiary. Call 1-800-421-4655.',
    '<strong>Southwest Rapid Rewards:</strong> Points cannot be transferred but may be used by the estate. Contact Southwest.',
    '<strong>Hotel programs</strong> (Marriott Bonvoy, Hilton Honors, IHG One): most allow transfer to a surviving spouse; policies vary for other family members.',
    '<strong>Credit card points</strong> (Chase Ultimate Rewards, Amex Membership Rewards, Citi ThankYou): typically transferable to the estate or a named beneficiary — contact the card issuer.',
    'Before closing any account, ask specifically about the points/miles balance and transfer process.'
  ],
  tip = 'For frequent travelers, loyalty program balances can represent thousands of dollars in value. A single long-haul business class award can be worth $5,000–$10,000 in retail ticket value.'
WHERE sort_order = 37;

-- ── Personal & Memberships ────────────────────────────────────────────────────

UPDATE public.tasks SET
  steps = ARRAY[
    '<strong>Employer-sponsored insurance:</strong> Notify HR within 30 days. The deceased''s coverage ends. A surviving spouse or dependents can continue coverage via COBRA for up to 36 months.',
    '<strong>COBRA election:</strong> Notify the plan administrator within 60 days of receiving the COBRA election notice. COBRA is expensive (full premium + 2% admin fee) but preserves access to the same plan.',
    '<strong>Healthcare.gov (ACA Marketplace):</strong> The death of a covered individual is a Special Enrollment Period — surviving family members have 60 days to enroll in a new plan.',
    '<strong>Medicare:</strong> Handled via SSA notification (see Government section).',
    'A surviving spouse who was on the deceased''s plan must obtain their own coverage immediately to avoid a gap.',
    'If the deceased had their own individual plan: cancel directly with the insurer with a death certificate.'
  ],
  states = '[{"state":"California","detail":"CA Covered (state marketplace) has similar SEP rules to Healthcare.gov. CA also has Medi-Cal (Medicaid) which may be available for surviving low-income family members."},{"state":"Massachusetts","detail":"MA Health Connector provides state-specific enrollment options."}]'::jsonb,
  template = 'Health Insurance Cancellation Letter'
WHERE sort_order = 38;

UPDATE public.tasks SET
  steps = ARRAY[
    '<strong>Controlled substances</strong> (opioids, benzodiazepines, etc.): Do not flush down the toilet (environmental harm) unless instructions specifically say to. Return to a DEA-authorized collection site (most pharmacies have a drop-box). Or use a drug take-back program at police stations.',
    '<strong>Other medications:</strong> Mix with coffee grounds, dirt, or cat litter in a sealed bag and discard in household trash. Or use a take-back site.',
    '<strong>Rented medical equipment</strong> (hospital beds, oxygen concentrators, wheelchairs): Contact the rental company to schedule pickup. Equipment still on rental generates ongoing fees until returned.',
    '<strong>Purchased durable medical equipment:</strong> May be donated to medical supply organizations, listed for sale, or disposed of.',
    'Contact all pharmacies where the deceased had accounts to stop refill reminders.',
    'Notify the prescribing physicians that the patient has passed — helps close open prescriptions and prevent fraudulent refill attempts.'
  ]
WHERE sort_order = 39;

UPDATE public.tasks SET
  steps = ARRAY[
    'Contact the gym or fitness studio directly — in person, by phone, or by mail.',
    'Most gyms will cancel immediately with a death certificate. Request this in writing.',
    'Request a refund of any prepaid membership period that extends beyond the date of cancellation.',
    'Check whether the membership was part of a corporate wellness benefit — contact the employer''s HR to cancel separately.',
    'For national chains (Planet Fitness, Equinox, etc.): call member services and ask for the bereavement cancellation process.',
    'Check bank and credit card statements to confirm cancellation is reflected — some gyms have difficult auto-renewal practices.'
  ]
WHERE sort_order = 40;

UPDATE public.tasks SET
  steps = ARRAY[
    'Contact the carrier''s customer service or go to a store with a death certificate.',
    '<strong>AT&T:</strong> Call 1-800-331-0500 or visit a store. ETF waived with death certificate.',
    '<strong>Verizon:</strong> Call 1-800-922-0204. Request bereavement cancellation.',
    '<strong>T-Mobile:</strong> Call 1-800-937-8997. ETF waived with death certificate.',
    '<strong>If the phone number should be transferred</strong> (e.g., the surviving spouse used it as a business number): request a number port to a new account.',
    'Cancel any device payment plans — return or keep the device but clarify any remaining balance.',
    'The phone itself: wipe and donate, or retain for the family to use.',
    'Cancel Apple Watch cellular plans and any connected device plans (tablets, smartwatches) separately.'
  ],
  template = 'Cell Phone Carrier Notification Letter'
WHERE sort_order = 41;

UPDATE public.tasks SET
  steps = ARRAY[
    'Identify all professional memberships from the deceased''s records, email, and bank statements.',
    'Common examples: State Bar (attorneys), AMA/state medical associations (physicians), professional engineering licenses, CPA certifications, real estate licenses, etc.',
    'Contact each association with a death certificate. Request cancellation and a prorated refund of annual dues.',
    'For licensed professionals: file a notice of death with the state licensing board if required — this formally closes the license and prevents fraudulent use.',
    'For board memberships or officer positions: provide written notice to the organization so they can formally appoint a successor.',
    'Professional certifications (CPA, PMP, CFA, etc.): notify the credentialing body to retire the certification.'
  ]
WHERE sort_order = 42;

-- ── Record Retention ──────────────────────────────────────────────────────────

UPDATE public.tasks SET
  steps = ARRAY[
    'Keep the signed return, all supporting schedules, and proof of filing (IRS acceptance confirmation or certified mail receipt).',
    'If a refund was received, keep the Form 1310 (refund claim for deceased taxpayer) and any correspondence with the IRS.',
    'The 7-year clock starts from the <strong>filing date</strong>, not the date of death.',
    'Store in a clearly labeled folder: "Tax Records — [Deceased Name] — Final 1040 — [Tax Year]."',
    'After 7 years: these can be securely shredded.'
  ],
  tip = 'Your CPA will have a copy of the filed return. Ask them to confirm they will retain it for at least 3 years on their end as a backup, but keep your own copy for the full 7 years regardless.',
  exec_note = 'The executor is responsible for maintaining these records until the 7-year retention period expires.'
WHERE sort_order = 43;

UPDATE public.tasks SET
  steps = ARRAY[
    'Keep the signed Form 1041 for each year it was filed, along with all supporting schedules and K-1s issued to beneficiaries.',
    'If the estate earned income for multiple years, you may have multiple Form 1041 filings. Keep all of them for 7 years from each respective filing date.',
    'Keep copies of all K-1s issued — beneficiaries may need these for their own tax filings and could contact you for copies years later.'
  ],
  exec_note = 'The executor signs Form 1041 as the fiduciary and is responsible for retaining it for the full 7 years.'
WHERE sort_order = 44;

UPDATE public.tasks SET
  steps = ARRAY[
    'The 3-year audit window applies, but 7 years is the conservative standard.',
    'If estate tax was paid: keep the proof of payment permanently, not just 7 years. A future state tax claim or audit can surface unexpectedly years later.',
    'Keep all appraisals and supporting documentation that were filed with Form 706 — these establish the values used for estate tax purposes.'
  ],
  exec_note = 'The executor signs Form 706 and is personally responsible for accurate reporting of estate values.'
WHERE sort_order = 45;

UPDATE public.tasks SET
  steps = ARRAY[
    'Keep the signed final state income tax return for the year of death.',
    'If the estate was required to file a state fiduciary income tax return, keep that for 7 years as well.',
    'If the estate owed state estate or inheritance tax, keep those returns and proof of payment for 7 years.',
    'States with estate taxes (Oregon threshold $1M, Massachusetts $2M, Washington State $2.193M, Illinois $4M, New York $6.94M, Maryland $5M) — keep all estate tax filings and payment records for the full 7 years.'
  ],
  exec_note = 'The executor is responsible for filing and retaining all state tax returns related to the estate.'
WHERE sort_order = 46;

UPDATE public.tasks SET
  steps = ARRAY[
    'Keep the original signed will — not just a copy. The original is the legally operative document.',
    'If there were any codicils (amendments to the will), keep all of them alongside the original.',
    'Store in a fireproof location (fireproof safe, bank safe deposit box, or with your estate attorney).',
    'Tell a trusted person where the original is kept. If it cannot be found when needed, a copy may not be accepted by a court.'
  ],
  warn = 'Destroying or concealing a will is a crime in all 50 states. Even if you believe the will is no longer relevant because the estate is closed, keep the original indefinitely.'
WHERE sort_order = 47;

UPDATE public.tasks SET
  steps = ARRAY[
    'Keep all certified copies of your Letters Testamentary or Letters of Administration.',
    'These documents prove your legal authority to have acted on behalf of the estate. If a financial institution, creditor, or beneficiary later questions whether you had authority to take a particular action, this is your primary evidence.',
    'Note the expiration dates, if any — some states issue Letters with an expiration. If yours expired during administration, keep a record of any renewal Letters as well.'
  ],
  exec_note = 'Letters Testamentary are the executor''s primary proof of authority. Retain all certified copies permanently.'
WHERE sort_order = 48;

UPDATE public.tasks SET
  steps = ARRAY[
    'Keep: the initial petition to open probate, the court order appointing you as executor, proof of publication of the creditor notice, all accountings filed with the court, and the final order of distribution.',
    'If any contested matters arose (a will challenge, a creditor dispute, a beneficiary objection), keep all related filings permanently.',
    'These documents establish the legal history of the estate administration. If a beneficiary later claims they were not properly notified, or that a distribution was unauthorized, these records are your defense.'
  ],
  exec_note = 'The executor filed these documents and is responsible for maintaining a complete record of all court proceedings.'
WHERE sort_order = 49;

UPDATE public.tasks SET
  steps = ARRAY[
    'Keep the formal inventory with all asset values as of the date of death.',
    'Keep all appraisal reports (real property, personal property, business interests) that supported the inventory values.',
    'Keep documentation of how each asset was classified: probate vs. non-probate, community property vs. separate property, etc.',
    'This inventory is the foundation for everything that followed — distributions, tax filings, and creditor payments all trace back to it.'
  ],
  exec_note = 'The executor signed and filed the inventory. Retain it permanently as the authoritative record of what was in the estate.'
WHERE sort_order = 50;

UPDATE public.tasks SET
  steps = ARRAY[
    'Every heir who received a distribution should have signed a Receipt and Release acknowledging they received their share and releasing the executor from further claims.',
    'Keep the original signed document for every heir — not just copies.',
    'If an heir later claims they were not paid, or received less than they were entitled to, this document is your primary — and often only — defense.',
    'If a notarized Receipt and Release was obtained, keep the notarized original.',
    'If any heir refused to sign at the time of distribution: document that refusal in writing immediately, note the date, and keep that documentation permanently alongside your other records.'
  ],
  warn = 'This is the single most important document in the entire estate record. Do not distribute assets to any heir without obtaining a signed Receipt and Release first, and do not discard these documents ever.',
  exec_note = 'As executor, you are personally protected by having a signed Receipt and Release from every heir. This is non-negotiable.'
WHERE sort_order = 51;

UPDATE public.tasks SET
  steps = ARRAY[
    'Keep the deed of transfer and the appraisal showing the property''s fair market value as of the date of death.',
    '<strong>Pass these documents to the heir who received the property</strong> at estate closure — do not just keep them yourself. The heir will need them when they eventually sell, which could be decades from now.',
    'When you pass them, include a written note explaining: "This appraisal establishes your stepped-up cost basis for capital gains purposes. Keep this document permanently and give it to your accountant when you sell the property."',
    'If the heir does not understand what stepped-up basis means, explain it plainly: "The IRS treats your cost basis as the value on the date you inherited it, not the price it was originally purchased for. This can eliminate a very large tax bill when you eventually sell."'
  ],
  tip = 'This is one of the most commonly overlooked record-keeping obligations in estate administration. Many heirs sell inherited property years later and discover they owe large capital gains taxes because they cannot produce the date-of-death appraisal. Putting this in their hands at closure is one of the most concretely valuable things you can do as executor.',
  exec_note = 'Pass the original appraisal documents to each heir at estate closure, with a written explanation of their purpose.'
WHERE sort_order = 52;

UPDATE public.tasks SET
  steps = ARRAY[
    'For all appraised personal property (jewelry, fine art, antiques, collectibles, vehicles of value): pass the appraisal documents to the heir who received those items.',
    'Include a written explanation: "This appraisal establishes your cost basis for tax purposes. Keep it for as long as you own this item, plus 7 years after you sell it."',
    'If items were distributed without a formal appraisal, document the estimated value used for estate purposes and the basis for that estimate. This is better than nothing if a tax question arises later.'
  ],
  exec_note = 'Pass appraisal documentation to heirs at closure. Note in your records what was given to whom and when.'
WHERE sort_order = 53;

UPDATE public.tasks SET
  steps = ARRAY[
    'Keep all monthly statements for the estate bank account from opening through final closure.',
    'Keep records of every wire transfer and check drawn on the account, including the payee and purpose.',
    'If the estate received any income (interest, rental income, dividends), keep documentation of those receipts.',
    'The 7-year clock starts from the date the estate account is formally closed, not the date of death.'
  ],
  exec_note = 'The executor opened and managed the estate account and is responsible for retaining all related statements for 7 years after closure.'
WHERE sort_order = 54;

UPDATE public.tasks SET
  steps = ARRAY[
    'Keep the brokerage or investment account statements showing the value of each holding as of the date of death.',
    '<strong>Pass copies to the heirs who received those investments</strong>, along with a written explanation of why the date-of-death value matters for their taxes when they sell.',
    'If securities were sold during estate administration, keep the sale confirmation and proceeds documentation.'
  ],
  exec_note = 'Retain originals for 7 years and pass copies to each heir who received investment assets at estate closure.'
WHERE sort_order = 55;

UPDATE public.tasks SET
  steps = ARRAY[
    'Retain: the completed claim forms, the insurer''s acknowledgment of each claim, the settlement or payment documentation, and any correspondence regarding disputed or delayed claims.',
    'This applies to: life insurance, annuities, accidental death policies, any vehicle insurance claims, and homeowner''s insurance claims related to the estate.',
    'If any claim was denied, keep the denial letter and any appeal documentation.'
  ],
  exec_note = 'The executor filed or oversaw all insurance claims during administration and is responsible for retaining all related documentation.'
WHERE sort_order = 56;

UPDATE public.tasks SET
  steps = ARRAY[
    'For every creditor paid during estate administration: keep the creditor''s statement of amount owed, the check or wire transfer record showing payment, and any written release or payoff confirmation from the creditor.',
    'For every creditor claim denied: keep the written denial letter and the basis for denial.',
    'For any debts that were negotiated or settled for less than the full amount: keep the settlement agreement signed by both parties.',
    'Do not assume a creditor will maintain their own records accurately. Your documentation is your only protection if a paid debt is later disputed.'
  ],
  exec_note = 'The executor is personally responsible for paying valid estate debts. Complete documentation protects you against any later claim of non-payment.'
WHERE sort_order = 57;

UPDATE public.tasks SET
  steps = ARRAY[
    'Keep all engagement letters, invoices, and payment records for every professional retained during the estate: estate attorney, CPA, appraiser, real estate agent, Loss Ally.',
    'Keep any formal opinions or advice letters received from your estate attorney — particularly the probate strategy, any UPL boundary guidance, and any opinions on disputed matters.',
    'If a beneficiary later challenges the reasonableness of professional fees charged to the estate, these records demonstrate that appropriate guidance was obtained and followed.'
  ],
  exec_note = 'Professional fees paid from estate assets are subject to beneficiary review. Complete records protect the executor from challenge.'
WHERE sort_order = 58;

UPDATE public.tasks SET
  steps = ARRAY[
    'At estate closure, prepare a simple one-page document for each heir listing: (1) what documents they are being given, (2) what each document is for, (3) how long they should keep it.',
    'Specifically flag the appraisals and investment statements that establish their stepped-up cost basis. Use plain language: "When you sell this property / these investments, give this appraisal to your accountant. It tells the IRS what you paid for it, which reduces your tax bill."',
    'A heir who sells inherited property in 2045 will not remember to call you before closing — these instructions and documents need to be in their hands today.',
    'If any heir is a minor, give the record retention package to their guardian with instructions to preserve it until the heir is an adult.',
    'Keep a copy of what you gave each heir, signed and dated by them as acknowledgment of receipt.'
  ],
  tip = 'The record retention guide is one of the most lasting gifts you can give your beneficiaries as executor. It costs you one hour of preparation at closure and can save each heir thousands of dollars in taxes decades from now.',
  exec_note = 'As executor, preparing and delivering a record retention guide to each heir is one of your final obligations before formally closing the estate.'
WHERE sort_order = 59;
