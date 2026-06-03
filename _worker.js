export default {
  async fetch(request, env) {
    const url = new URL(request.url)

    // ── API routes ────────────────────────────────────────────────────────────────
    if (request.method === 'POST' && url.pathname === '/api/intake') {
      return handleIntake(request, env)
    }
    if (request.method === 'POST' && url.pathname === '/api/invite') {
      return handleInvite(request, env)
    }
    if (request.method === 'GET' && url.pathname === '/api/clients') {
      return handleClients(request, env)
    }
    if (request.method === 'PATCH' && url.pathname === '/api/update-plan') {
      return handleUpdatePlan(request, env)
    }
    if (url.pathname === '/api/messages') {
      return handleMessages(request, env, url)
    }
    if (request.method === 'POST' && url.pathname === '/api/client-message') {
      return handleClientMessage(request, env)
    }
    if (request.method === 'POST' && url.pathname === '/api/mark-read') {
      return handleMarkRead(request, env)
    }
    if (request.method === 'POST' && url.pathname === '/api/client-mark-read') {
      return handleClientMarkRead(request, env)
    }

    // ── Static asset serving + env-var injection ────────────────────────────────
    const response = await env.ASSETS.fetch(request)

    const contentType = response.headers.get('content-type') || ''
    if (!contentType.includes('text/html')) {
      return response
    }

    // Inject Supabase env vars as the first script inside <head>
    const snippet = `<script>` +
      `window.SUPABASE_URL=${JSON.stringify(env.SUPABASE_URL || '')};` +
      `window.SUPABASE_ANON_KEY=${JSON.stringify(env.SUPABASE_ANON_KEY || '')};` +
      `</script>`

    const html = await response.text()
    const injected = html.replace('<head>', `<head>${snippet}`)

    const headers = new Headers(response.headers)
    headers.delete('content-length')

    return new Response(injected, {
      status: response.status,
      statusText: response.statusText,
      headers,
    })
  },
}


// ── /api/intake ─────────────────────────────────────────────────────────────
// Receives the intake form POST, stores to Supabase, forwards to Formspree.
async function handleIntake(request, env) {
  let data
  try {
    const ct = request.headers.get('content-type') || ''
    if (ct.includes('application/x-www-form-urlencoded') || ct.includes('multipart/form-data')) {
      const fd = await request.formData()
      data = {}
      for (const [key, value] of fd.entries()) {
        if (key in data) {
          data[key] = Array.isArray(data[key]) ? [...data[key], value] : [data[key], value]
        } else {
          data[key] = value
        }
      }
    } else {
      data = await request.json()
    }
  } catch {
    return jsonResponse({ error: 'Could not parse request body' }, 400)
  }

  // Normalise assets to an array
  const assets = Array.isArray(data.assets)
    ? data.assets
    : data.assets ? [data.assets] : []

  // Insert into Supabase using the service role key (bypasses RLS)
  const supabaseInsert = await fetch(`${env.SUPABASE_URL}/rest/v1/intake_submissions`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${env.SUPABASE_SERVICE_ROLE_KEY}`,
      'apikey': env.SUPABASE_SERVICE_ROLE_KEY,
      'Prefer': 'return=minimal',
    },
    body: JSON.stringify({
      deceased_first_name: str(data.deceased_first_name),
      deceased_last_name:  str(data.deceased_last_name),
      date_of_passing:     str(data.date_of_passing) || null,
      city_of_death:       str(data.city_of_death),
      state:               str(data.state),
      first_name:          str(data.first_name),
      last_name:           str(data.last_name),
      email:               str(data.email),
      phone:               str(data.phone),
      relationship:        str(data.relationship),
      executor_status:     str(data.executor_status),
      will_or_trust:       str(data.will_or_trust),
      attorney_status:     str(data.attorney_status),
      capacity:            str(data.capacity),
      assets,
      stage:               str(data.stage),
      family_involvement:  str(data.family_involvement),
      distance:            str(data.distance),
      how_doing:           str(data.how_doing),
      consultation_goal:   str(data.consultation_goal),
      anything_else:       str(data.anything_else),
      availability:        Array.isArray(data.availability) ? data.availability : (data.availability ? [data.availability] : []),
      timezone:            str(data.timezone),
      referral_source:     str(data.referral_source),
    }),
  })

  let supabaseError = null
  if (!supabaseInsert.ok) {
    supabaseError = await supabaseInsert.text()
    console.error('[intake] Supabase insert failed:', supabaseError)
  }

  // Send notification email via Resend
  const deceasedName  = [str(data.deceased_first_name), str(data.deceased_last_name)].filter(Boolean).join(' ') || '—'
  const executorName  = [str(data.first_name), str(data.last_name)].filter(Boolean).join(' ') || '—'
  const location      = [str(data.city_of_death), str(data.state)].filter(Boolean).join(', ') || '—'
  const assetList     = assets.length ? assets.join(', ') : '—'
  const availList     = Array.isArray(data.availability) ? data.availability.join(', ') : str(data.availability) || '—'

  const row = (label, value) => value
    ? `<tr><td style="padding:7px 0;border-bottom:1px solid #E2DDD4;color:#8D9D6A;font-size:11px;letter-spacing:0.08em;text-transform:uppercase;width:38%;vertical-align:top;">${label}</td><td style="padding:7px 0;border-bottom:1px solid #E2DDD4;font-size:13px;">${value}</td></tr>`
    : ''

  const block = (label, value) => value
    ? `<div style="margin-bottom:16px;"><p style="font-size:11px;letter-spacing:0.08em;text-transform:uppercase;color:#8D9D6A;margin:0 0 6px;">${label}</p><p style="font-size:13px;line-height:1.7;background:#faf8f4;border-left:3px solid #C9A870;padding:10px 14px;margin:0;">${value}</p></div>`
    : ''

  await fetch('https://api.resend.com/emails', {
    method: 'POST',
    headers: { 'Authorization': `Bearer ${env.RESEND_API_KEY}`, 'Content-Type': 'application/json' },
    body: JSON.stringify({
      from: 'Loss Ally <support@lossally.com>',
      to:   ['support@lossally.com'],
      subject: `New intake — ${executorName} (${deceasedName})`,
      html: `
<div style="font-family:Georgia,serif;max-width:600px;margin:0 auto;color:#2C2C28;">
  <div style="background:#f6f1e6;padding:24px 28px 16px;border-bottom:2px solid #E2DDD4;">
    <p style="font-size:11px;letter-spacing:0.12em;text-transform:uppercase;color:#8D9D6A;margin:0 0 6px;">Loss Ally — New Intake</p>
    <h1 style="font-size:22px;font-weight:400;margin:0;">${executorName}</h1>
    <p style="font-size:13px;color:#666;margin:4px 0 0;">Submitted ${new Date().toLocaleDateString('en-US',{month:'long',day:'numeric',year:'numeric'})}</p>
  </div>
  <div style="padding:24px 28px;">

    <table style="width:100%;border-collapse:collapse;margin-bottom:24px;">
      ${row('Contact', `<a href="mailto:${str(data.email)||''}" style="color:#5b6e5b;">${str(data.email)||'—'}</a> · ${str(data.phone)||'—'}`)}
      ${row('Relationship', str(data.relationship))}
      ${row('Deceased', deceasedName)}
      ${row('Date of Passing', str(data.date_of_passing))}
      ${row('Location', location)}
      ${row('Stage', str(data.stage))}
      ${row('Executor Status', str(data.executor_status))}
      ${row('Will / Trust', str(data.will_or_trust))}
      ${row('Attorney', str(data.attorney_status))}
      ${row('Capacity to Handle', str(data.capacity))}
      ${row('Assets', assetList)}
      ${row('Family Involvement', str(data.family_involvement))}
      ${row('Location (Executor)', str(data.distance))}
      ${row('Availability', availList)}
      ${row('Timezone', str(data.timezone))}
      ${row('Referral', str(data.referral_source))}
    </table>

    ${block("What they're hoping for", str(data.consultation_goal))}
    ${block("How they're doing", str(data.how_doing))}
    ${block("Anything else", str(data.anything_else))}

    ${supabaseError ? `<div style="margin-top:16px;padding:10px 14px;background:#FDF0F0;border-left:3px solid #9E3030;font-size:12px;color:#9E3030;font-family:monospace;"><strong>⚠ Supabase insert failed — submission NOT saved to database:</strong><br>${supabaseError}</div>` : '<p style="font-size:11px;color:#8D9D6A;text-align:center;margin-top:12px;">✓ Saved to Supabase</p>'}
    <div style="margin-top:24px;padding-top:20px;border-top:1px solid #E2DDD4;text-align:center;">
      <a href="https://lossally.com/portal-advisor.html" style="display:inline-block;background:#5b6e5b;color:#fff;text-decoration:none;font-size:13px;padding:10px 22px;border-radius:6px;">View in Advisor Portal</a>
    </div>
  </div>
</div>`,
    }),
  }).catch(err => console.error('[intake] Resend failed:', err))

  // Redirect to the thank-you landing page
  return Response.redirect(new URL('/intake-thank-you.html', request.url).href, 302)
}


// ── /api/invite ──────────────────────────────────────────────────────────────
// Advisor-only. Invites a prospect as a Supabase user, creates their profile
// pre-populated from the intake submission, and marks the submission as 'client'.
async function handleInvite(request, env) {
  // Verify the caller has a valid Supabase session.
  // The portal-advisor.html frontend already enforces advisor-only access
  // via requireAdvisor(), so a valid JWT is sufficient here.
  const authHeader = request.headers.get('Authorization') || ''
  if (!authHeader.startsWith('Bearer ')) {
    return jsonResponse({ error: 'Unauthorized' }, 401)
  }
  const jwt = authHeader.slice(7)

  const userRes = await fetch(`${env.SUPABASE_URL}/auth/v1/user`, {
    headers: { 'Authorization': `Bearer ${jwt}`, 'apikey': env.SUPABASE_ANON_KEY },
  })
  if (!userRes.ok) return jsonResponse({ error: 'Invalid session' }, 401)

  // Parse request body — the frontend passes the full intake row it already has loaded
  let body
  try { body = await request.json() } catch { return jsonResponse({ error: 'Invalid JSON' }, 400) }
  const { intake_id, intake } = body
  if (!intake_id) return jsonResponse({ error: 'intake_id required' }, 400)
  if (!intake || !intake.email) return jsonResponse({ error: 'intake data with email is required' }, 400)

  const plan = body.plan || 'guided'

  // Generate the invite link. For new users use type=invite; if the email already
  // exists in Supabase auth (resend case), fall back to type=recovery which works
  // identically from the client's perspective — they land on portal.html and set a password.
  const generateLink = async (type) => fetch(`${env.SUPABASE_URL}/auth/v1/admin/generate_link`, {
    method: 'POST',
    headers: { ...serviceHeaders(env), 'Content-Type': 'application/json' },
    body: JSON.stringify({
      type,
      email:       intake.email,
      data:        { full_name: fullName(intake.first_name, intake.last_name) },
      redirect_to: 'https://lossally.com/portal.html',
    }),
  })

  let linkRes = await generateLink('invite')
  let linkData = await linkRes.json()

  if (!linkRes.ok && linkData.error_code === 'email_exists') {
    linkRes  = await generateLink('recovery')
    linkData = await linkRes.json()
  }

  if (!linkRes.ok) {
    console.error('[invite] generate_link failed:', JSON.stringify(linkData))
    return jsonResponse({ error: 'Failed to generate invite link', detail: JSON.stringify(linkData) }, 500)
  }

  const inviteLink = linkData.properties?.action_link || linkData.action_link
  const userId     = linkData.user?.id

  if (!inviteLink) {
    return jsonResponse({ error: 'Invite link missing from Supabase response', raw: linkData }, 500)
  }

  // Build client_details from intake data
  const client_details = {
    deceased_full_name:    fullName(intake.deceased_first_name, intake.deceased_last_name),
    date_of_death:         intake.date_of_passing || '',
    city_of_death:         intake.city_of_death || '',
    estate_state:          intake.state || '',
    executor_name:         fullName(intake.first_name, intake.last_name),
    executor_email:        intake.email || '',
    executor_phone:        intake.phone || '',
    executor_relationship: intake.relationship || '',
  }

  // Create the profile pre-populated with intake data.
  // Try full insert first; if it fails (e.g. column not yet migrated), fall back to
  // a minimal insert so the client always lands in Active Clients.
  const profilePayload = { id: userId, full_name: fullName(intake.first_name, intake.last_name), email: intake.email, role: 'client', plan, client_details }
  let profileRes = await fetch(`${env.SUPABASE_URL}/rest/v1/profiles`, {
    method: 'POST',
    headers: { ...serviceHeaders(env), 'Content-Type': 'application/json', 'Prefer': 'resolution=merge-duplicates' },
    body: JSON.stringify(profilePayload),
  })
  if (!profileRes.ok) {
    const profileErr = await profileRes.text()
    console.error('[invite] profile upsert failed:', profileErr, '— retrying with minimal payload')
    // Retry without extended columns in case a migration hasn't been run yet
    const minimalPayload = { id: userId, full_name: fullName(intake.first_name, intake.last_name), email: intake.email, role: 'client' }
    profileRes = await fetch(`${env.SUPABASE_URL}/rest/v1/profiles`, {
      method: 'POST',
      headers: { ...serviceHeaders(env), 'Content-Type': 'application/json', 'Prefer': 'resolution=merge-duplicates' },
      body: JSON.stringify(minimalPayload),
    })
    if (!profileRes.ok) {
      const fatalErr = await profileRes.text()
      console.error('[invite] profile upsert failed on minimal payload too:', fatalErr)
      return jsonResponse({ error: 'Failed to create client profile', detail: fatalErr }, 500)
    }
  }

  // Seed all tasks for the new client so the advisor can manage them immediately
  const tasksRes = await fetch(`${env.SUPABASE_URL}/rest/v1/tasks?select=id&is_template=eq.true`, {
    headers: serviceHeaders(env),
  })
  if (tasksRes.ok && userId) {
    const allTasks = await tasksRes.json()
    const seed = allTasks.map(t => ({
      client_id: userId, task_id: t.id, done: false, excluded: false, notes: '',
    }))
    await fetch(`${env.SUPABASE_URL}/rest/v1/client_tasks`, {
      method: 'POST',
      headers: { ...serviceHeaders(env), 'Content-Type': 'application/json', 'Prefer': 'resolution=ignore-duplicates' },
      body: JSON.stringify(seed),
    })
  }

  // Seed welcome message for the new client
  if (userId) {
    const firstName = fullName(intake.first_name, intake.last_name).split(' ')[0] || 'there'
    await fetch(`${env.SUPABASE_URL}/rest/v1/advisor_messages`, {
      method: 'POST',
      headers: { ...serviceHeaders(env), 'Content-Type': 'application/json', 'Prefer': 'return=minimal' },
      body: JSON.stringify({
        client_id: userId,
        sender_role: 'advisor',
        body: `Welcome to your Loss Ally portal, ${firstName}. This is your space to track your case and stay in touch. Feel free to leave a note here any time — I'm here to help.`,
      }),
    })
  }

  // Mark the intake submission as 'client' and link the profile
  await fetch(
    `${env.SUPABASE_URL}/rest/v1/intake_submissions?id=eq.${encodeURIComponent(intake_id)}`,
    {
      method: 'PATCH',
      headers: { ...serviceHeaders(env), 'Content-Type': 'application/json' },
      body: JSON.stringify({ status: 'client', profile_id: userId }),
    }
  )

  // Send the invite email via Resend with Loss Ally branding
  const clientName = fullName(intake.first_name, intake.last_name)
  const firstName  = clientName.split(' ')[0]

  const portalDescription = plan === 'guided'
    ? `We've set up your personal portal where you'll find your estate administration checklist, letter templates, and resources — everything you need, in one place.`
    : `We've set up your personal portal where you can follow your case progress and stay up to date as we work through the estate administration process together.`

  await fetch('https://api.resend.com/emails', {
    method: 'POST',
    headers: { 'Authorization': `Bearer ${env.RESEND_API_KEY}`, 'Content-Type': 'application/json' },
    body: JSON.stringify({
      from:    'Loss Ally <support@lossally.com>',
      to:      [intake.email],
      subject: 'Your Loss Ally portal is ready',
      html: `
<div style="font-family:Georgia,serif;max-width:560px;margin:0 auto;color:#2C2C28;">
  <div style="background:#f6f1e6;padding:28px 32px 20px;border-bottom:2px solid #E2DDD4;">
    <p style="font-size:11px;letter-spacing:0.14em;text-transform:uppercase;color:#8D9D6A;margin:0 0 8px;">Loss Ally</p>
    <h1 style="font-family:Georgia,serif;font-size:26px;font-weight:400;margin:0;letter-spacing:-0.01em;">Your portal is ready, ${firstName}.</h1>
  </div>
  <div style="padding:28px 32px;">
    <p style="font-size:15px;line-height:1.8;color:#2C2C28;opacity:0.8;margin:0 0 20px;">
      Thank you for choosing Loss Ally. ${portalDescription}
    </p>
    <p style="font-size:15px;line-height:1.8;color:#2C2C28;opacity:0.8;margin:0 0 28px;">
      Click the button below to create your password and access your portal. This link expires in 24 hours.
    </p>
    <div style="text-align:center;margin-bottom:28px;">
      <a href="${inviteLink}" style="display:inline-block;background:#5b6e5b;color:#ffffff;text-decoration:none;font-size:15px;font-family:Georgia,serif;padding:14px 32px;border-radius:8px;letter-spacing:0.01em;">
        Set Up My Portal →
      </a>
    </div>
    <p style="font-size:13px;line-height:1.7;color:#2C2C28;opacity:0.5;margin:0 0 6px;">
      If the button doesn't work, copy and paste this link into your browser:
    </p>
    <p style="font-size:12px;color:#5b6e5b;word-break:break-all;margin:0 0 28px;">
      <a href="${inviteLink}" style="color:#5b6e5b;">${inviteLink}</a>
    </p>
    <div style="border-top:1px solid #E2DDD4;padding-top:20px;">
      <p style="font-size:13px;line-height:1.7;color:#2C2C28;opacity:0.5;margin:0;">
        Questions? Reply to this email or reach us at <a href="mailto:support@lossally.com" style="color:#5b6e5b;">support@lossally.com</a>.
      </p>
    </div>
  </div>
</div>`,
    }),
  }).catch(err => console.error('[invite] Resend email failed:', err))

  return jsonResponse({ success: true, user_id: userId })
}


// ── /api/clients ─────────────────────────────────────────────────────────────
// Returns all client profiles. Uses service role to bypass RLS.
// Caller must have a valid advisor session (JWT verified).
async function handleClients(request, env) {
  const authHeader = request.headers.get('Authorization') || ''
  if (!authHeader.startsWith('Bearer ')) return jsonResponse({ error: 'Unauthorized' }, 401)
  const jwt = authHeader.slice(7)
  const userRes = await fetch(`${env.SUPABASE_URL}/auth/v1/user`, {
    headers: { 'Authorization': `Bearer ${jwt}`, 'apikey': env.SUPABASE_ANON_KEY },
  })
  if (!userRes.ok) return jsonResponse({ error: 'Invalid session' }, 401)

  const res = await fetch(
    `${env.SUPABASE_URL}/rest/v1/profiles?role=eq.client&order=full_name`,
    { headers: serviceHeaders(env) }
  )
  if (!res.ok) {
    const detail = await res.text()
    return jsonResponse({ error: 'Failed to load clients', detail }, 500)
  }
  const clients = await res.json()

  // Attach unread-message counts so the advisor portal can show badges
  const unreadRes = await fetch(
    `${env.SUPABASE_URL}/rest/v1/advisor_messages?is_read_by_advisor=eq.false&sender_role=eq.client&select=client_id`,
    { headers: serviceHeaders(env) }
  )
  const unreadMap = {}
  if (unreadRes.ok) {
    for (const r of await unreadRes.json()) unreadMap[r.client_id] = (unreadMap[r.client_id] || 0) + 1
  }
  return jsonResponse(clients.map(c => ({ ...c, unread_count: unreadMap[c.id] || 0 })))
}


// ── /api/update-plan ─────────────────────────────────────────────────────────
// Advisor-only. Updates a client's plan using service role (bypasses RLS).
async function handleUpdatePlan(request, env) {
  const authHeader = request.headers.get('Authorization') || ''
  if (!authHeader.startsWith('Bearer ')) return jsonResponse({ error: 'Unauthorized' }, 401)
  const jwt = authHeader.slice(7)
  const userRes = await fetch(`${env.SUPABASE_URL}/auth/v1/user`, {
    headers: { 'Authorization': `Bearer ${jwt}`, 'apikey': env.SUPABASE_ANON_KEY },
  })
  if (!userRes.ok) return jsonResponse({ error: 'Invalid session' }, 401)

  let body
  try { body = await request.json() } catch { return jsonResponse({ error: 'Invalid JSON' }, 400) }
  const { client_id, plan } = body
  if (!client_id || !plan) return jsonResponse({ error: 'client_id and plan required' }, 400)
  if (!['guided', 'supported', 'full_service'].includes(plan)) return jsonResponse({ error: 'Invalid plan value' }, 400)

  const res = await fetch(
    `${env.SUPABASE_URL}/rest/v1/profiles?id=eq.${encodeURIComponent(client_id)}`,
    {
      method: 'PATCH',
      headers: { ...serviceHeaders(env), 'Content-Type': 'application/json', 'Prefer': 'return=minimal' },
      body: JSON.stringify({ plan }),
    }
  )
  if (!res.ok) {
    const detail = await res.text()
    return jsonResponse({ error: 'Failed to update plan', detail }, 500)
  }
  return jsonResponse({ success: true })
}


// ── /api/messages ─────────────────────────────────────────────────────────────
// Advisor-only. GET lists messages for a client; POST sends a message.
// Both use service role to bypass RLS.
async function handleMessages(request, env, url) {
  const authHeader = request.headers.get('Authorization') || ''
  if (!authHeader.startsWith('Bearer ')) return jsonResponse({ error: 'Unauthorized' }, 401)
  const jwt = authHeader.slice(7)
  const userRes = await fetch(`${env.SUPABASE_URL}/auth/v1/user`, {
    headers: { 'Authorization': `Bearer ${jwt}`, 'apikey': env.SUPABASE_ANON_KEY },
  })
  if (!userRes.ok) return jsonResponse({ error: 'Invalid session' }, 401)

  if (request.method === 'GET') {
    const clientId = url.searchParams.get('client_id')
    if (!clientId) return jsonResponse({ error: 'client_id required' }, 400)
    const res = await fetch(
      `${env.SUPABASE_URL}/rest/v1/advisor_messages?client_id=eq.${encodeURIComponent(clientId)}&order=created_at.asc`,
      { headers: serviceHeaders(env) }
    )
    if (!res.ok) {
      const detail = await res.text()
      return jsonResponse({ error: 'Failed to load messages', detail }, 500)
    }
    return jsonResponse(await res.json())
  }

  if (request.method === 'POST') {
    let body
    try { body = await request.json() } catch { return jsonResponse({ error: 'Invalid JSON' }, 400) }
    const { client_id, message_body } = body
    if (!client_id || !message_body) return jsonResponse({ error: 'client_id and message_body required' }, 400)

    // Check for existing unread advisor messages before inserting — if any exist,
    // the client already received an email and hasn't logged in yet, so skip this one.
    const unreadCheckRes = await fetch(
      `${env.SUPABASE_URL}/rest/v1/advisor_messages?client_id=eq.${encodeURIComponent(client_id)}&sender_role=eq.advisor&is_read_by_client=eq.false&select=id&limit=1`,
      { headers: serviceHeaders(env) }
    )
    const clientAlreadyUnread = unreadCheckRes.ok && (await unreadCheckRes.json()).length > 0

    const res = await fetch(`${env.SUPABASE_URL}/rest/v1/advisor_messages`, {
      method: 'POST',
      headers: { ...serviceHeaders(env), 'Content-Type': 'application/json', 'Prefer': 'return=representation' },
      body: JSON.stringify({ client_id, sender_role: 'advisor', body: message_body }),
    })
    if (!res.ok) {
      const detail = await res.text()
      return jsonResponse({ error: 'Failed to send message', detail }, 500)
    }
    const rows = await res.json()
    const newMsg = rows[0] || {}

    // Email the client only if they have no prior unread messages from the advisor
    const profileRes = !clientAlreadyUnread && await fetch(
      `${env.SUPABASE_URL}/rest/v1/profiles?id=eq.${encodeURIComponent(client_id)}&select=full_name,email`,
      { headers: serviceHeaders(env) }
    )
    if (profileRes && profileRes.ok) {
      const cp = (await profileRes.json())[0]
      if (cp?.email) {
        const firstName = (cp.full_name || '').split(' ')[0] || 'there'
        await fetch('https://api.resend.com/emails', {
          method: 'POST',
          headers: { 'Authorization': `Bearer ${env.RESEND_API_KEY}`, 'Content-Type': 'application/json' },
          body: JSON.stringify({
            from: 'Loss Ally <support@lossally.com>',
            to: [cp.email],
            subject: 'A new message from your advisor',
            html: `
<div style="font-family:Georgia,serif;max-width:560px;margin:0 auto;color:#2C2C28;">
  <div style="background:#f6f1e6;padding:24px 28px 16px;border-bottom:2px solid #E2DDD4;">
    <p style="font-size:11px;letter-spacing:0.14em;text-transform:uppercase;color:#8D9D6A;margin:0 0 8px;">Loss Ally</p>
    <h1 style="font-family:Georgia,serif;font-size:22px;font-weight:400;margin:0;">Your advisor left you a message, ${firstName}.</h1>
  </div>
  <div style="padding:24px 28px;">
    <div style="background:#f6f1e6;border-left:3px solid #5b6e5b;padding:14px 18px;border-radius:0 8px 8px 0;margin-bottom:24px;font-size:14px;line-height:1.75;color:#2C2C28;font-family:Georgia,serif;">${message_body}</div>
    <div style="text-align:center;margin-bottom:20px;">
      <a href="https://lossally.com/portal-dashboard.html" style="display:inline-block;background:#5b6e5b;color:#fff;text-decoration:none;font-size:14px;font-family:Georgia,serif;padding:12px 28px;border-radius:8px;">View in My Portal →</a>
    </div>
    <p style="font-size:12px;color:#2C2C28;opacity:0.4;text-align:center;margin:0;">Reply directly in your portal at lossally.com</p>
  </div>
</div>`,
          }),
        }).catch(err => console.error('[messages] client email failed:', err))
      }
    }

    return jsonResponse(newMsg)
  }

  return jsonResponse({ error: 'Method not allowed' }, 405)
}


// ── /api/client-message ───────────────────────────────────────────────────────
// Client sends a message. Emails the advisor only if this is the first unread
// message from this client (avoids spamming for back-to-back messages).
async function handleClientMessage(request, env) {
  const authHeader = request.headers.get('Authorization') || ''
  if (!authHeader.startsWith('Bearer ')) return jsonResponse({ error: 'Unauthorized' }, 401)
  const jwt = authHeader.slice(7)
  const userRes = await fetch(`${env.SUPABASE_URL}/auth/v1/user`, {
    headers: { 'Authorization': `Bearer ${jwt}`, 'apikey': env.SUPABASE_ANON_KEY },
  })
  if (!userRes.ok) return jsonResponse({ error: 'Invalid session' }, 401)
  const user = await userRes.json()
  const clientId = user.id

  let body
  try { body = await request.json() } catch { return jsonResponse({ error: 'Invalid JSON' }, 400) }
  const msgBody = (body.message_body || '').trim()
  if (!msgBody) return jsonResponse({ error: 'message_body required' }, 400)

  // Check for existing unread messages before inserting (to decide whether to email advisor)
  const unreadCheckRes = await fetch(
    `${env.SUPABASE_URL}/rest/v1/advisor_messages?client_id=eq.${encodeURIComponent(clientId)}&sender_role=eq.client&is_read_by_advisor=eq.false&select=id&limit=1`,
    { headers: serviceHeaders(env) }
  )
  const alreadyUnread = unreadCheckRes.ok && (await unreadCheckRes.json()).length > 0

  // Insert the message
  const insertRes = await fetch(`${env.SUPABASE_URL}/rest/v1/advisor_messages`, {
    method: 'POST',
    headers: { ...serviceHeaders(env), 'Content-Type': 'application/json', 'Prefer': 'return=representation' },
    body: JSON.stringify({ client_id: clientId, sender_role: 'client', body: msgBody }),
  })
  if (!insertRes.ok) {
    const detail = await insertRes.text()
    return jsonResponse({ error: 'Failed to send message', detail }, 500)
  }
  const newMsg = (await insertRes.json())[0] || {}

  // Email advisor only for the first unread message in a batch
  if (!alreadyUnread) {
    const profileRes = await fetch(
      `${env.SUPABASE_URL}/rest/v1/profiles?id=eq.${encodeURIComponent(clientId)}&select=full_name`,
      { headers: serviceHeaders(env) }
    )
    const clientName = profileRes.ok ? ((await profileRes.json())[0]?.full_name || 'A client') : 'A client'

    await fetch('https://api.resend.com/emails', {
      method: 'POST',
      headers: { 'Authorization': `Bearer ${env.RESEND_API_KEY}`, 'Content-Type': 'application/json' },
      body: JSON.stringify({
        from: 'Loss Ally <support@lossally.com>',
        to: ['support@lossally.com'],
        subject: `${clientName} sent you a message`,
        html: `
<div style="font-family:Georgia,serif;max-width:560px;margin:0 auto;color:#2C2C28;">
  <div style="background:#f6f1e6;padding:24px 28px 16px;border-bottom:2px solid #E2DDD4;">
    <p style="font-size:11px;letter-spacing:0.14em;text-transform:uppercase;color:#8D9D6A;margin:0 0 8px;">Loss Ally — Client Message</p>
    <h1 style="font-family:Georgia,serif;font-size:22px;font-weight:400;margin:0;">${clientName} sent you a message</h1>
  </div>
  <div style="padding:24px 28px;">
    <div style="background:#f6f1e6;border-left:3px solid #C9A870;padding:14px 18px;border-radius:0 8px 8px 0;margin-bottom:24px;font-size:14px;line-height:1.75;color:#2C2C28;font-family:Georgia,serif;">${msgBody}</div>
    <div style="text-align:center;margin-bottom:20px;">
      <a href="https://lossally.com/portal-advisor.html" style="display:inline-block;background:#5b6e5b;color:#fff;text-decoration:none;font-size:14px;font-family:Georgia,serif;padding:12px 28px;border-radius:8px;">View in Advisor Portal →</a>
    </div>
  </div>
</div>`,
      }),
    }).catch(err => console.error('[client-message] advisor email failed:', err))
  }

  return jsonResponse(newMsg)
}


// ── /api/client-mark-read ─────────────────────────────────────────────────────
// Client-only. Called when the client loads their messages thread.
// Marks all advisor messages as read so the next advisor message triggers a
// fresh email notification.
async function handleClientMarkRead(request, env) {
  const authHeader = request.headers.get('Authorization') || ''
  if (!authHeader.startsWith('Bearer ')) return jsonResponse({ error: 'Unauthorized' }, 401)
  const jwt = authHeader.slice(7)
  const userRes = await fetch(`${env.SUPABASE_URL}/auth/v1/user`, {
    headers: { 'Authorization': `Bearer ${jwt}`, 'apikey': env.SUPABASE_ANON_KEY },
  })
  if (!userRes.ok) return jsonResponse({ error: 'Invalid session' }, 401)
  const clientId = (await userRes.json()).id

  await fetch(
    `${env.SUPABASE_URL}/rest/v1/advisor_messages?client_id=eq.${encodeURIComponent(clientId)}&sender_role=eq.advisor&is_read_by_client=eq.false`,
    {
      method: 'PATCH',
      headers: { ...serviceHeaders(env), 'Content-Type': 'application/json', 'Prefer': 'return=minimal' },
      body: JSON.stringify({ is_read_by_client: true }),
    }
  )
  return jsonResponse({ success: true })
}


// ── /api/mark-read ────────────────────────────────────────────────────────────
// Advisor-only. Marks all client messages as read for a given client.
async function handleMarkRead(request, env) {
  const authHeader = request.headers.get('Authorization') || ''
  if (!authHeader.startsWith('Bearer ')) return jsonResponse({ error: 'Unauthorized' }, 401)
  const jwt = authHeader.slice(7)
  const userRes = await fetch(`${env.SUPABASE_URL}/auth/v1/user`, {
    headers: { 'Authorization': `Bearer ${jwt}`, 'apikey': env.SUPABASE_ANON_KEY },
  })
  if (!userRes.ok) return jsonResponse({ error: 'Invalid session' }, 401)

  let body
  try { body = await request.json() } catch { return jsonResponse({ error: 'Invalid JSON' }, 400) }
  const { client_id } = body
  if (!client_id) return jsonResponse({ error: 'client_id required' }, 400)

  await fetch(
    `${env.SUPABASE_URL}/rest/v1/advisor_messages?client_id=eq.${encodeURIComponent(client_id)}&sender_role=eq.client&is_read_by_advisor=eq.false`,
    {
      method: 'PATCH',
      headers: { ...serviceHeaders(env), 'Content-Type': 'application/json', 'Prefer': 'return=minimal' },
      body: JSON.stringify({ is_read_by_advisor: true }),
    }
  )
  return jsonResponse({ success: true })
}


// ── Helpers ──────────────────────────────────────────────────────────────────
function str(v) { return v ? String(v).trim() || null : null }
function fullName(first, last) { return [first, last].filter(Boolean).join(' ').trim() }
function serviceHeaders(env) {
  return {
    'Authorization': `Bearer ${env.SUPABASE_SERVICE_ROLE_KEY}`,
    'apikey': env.SUPABASE_SERVICE_ROLE_KEY,
  }
}
function jsonResponse(body, status = 200) {
  return new Response(JSON.stringify(body), {
    status,
    headers: { 'Content-Type': 'application/json' },
  })
}
