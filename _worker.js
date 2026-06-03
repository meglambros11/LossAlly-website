export default {
  async fetch(request, env) {
    const url = new URL(request.url)

    // ── API routes (POST only) ──────────────────────────────────────────────────
    if (request.method === 'POST' && url.pathname === '/api/intake') {
      return handleIntake(request, env)
    }
    if (request.method === 'POST' && url.pathname === '/api/invite') {
      return handleInvite(request, env)
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
      assets,
      stage:               str(data.stage),
      family_involvement:  str(data.family_involvement),
      distance:            str(data.distance),
      how_doing:           str(data.how_doing),
      consultation_goal:   str(data.consultation_goal),
      anything_else:       str(data.anything_else),
      availability:        str(data.availability),
      timezone:            str(data.timezone),
      referral_source:     str(data.referral_source),
    }),
  })

  if (!supabaseInsert.ok) {
    console.error('[intake] Supabase insert failed:', await supabaseInsert.text())
    // Still attempt Formspree so the advisor gets the email even if DB write fails
  }

  // Forward to Formspree for email notification to support@lossally.com
  const flat = {}
  for (const [k, v] of Object.entries(data)) {
    flat[k] = Array.isArray(v) ? v.join(', ') : v
  }
  await fetch('https://formspree.io/f/mqejygzd', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json', 'Accept': 'application/json' },
    body: JSON.stringify(flat),
  }).catch(() => {}) // non-fatal if Formspree is down

  // Redirect to intake page with ?submitted=1 so the form can show a thank-you
  return Response.redirect(new URL('/intake.html?submitted=1', request.url).href, 302)
}


// ── /api/invite ──────────────────────────────────────────────────────────────
// Advisor-only. Invites a prospect as a Supabase user, creates their profile
// pre-populated from the intake submission, and marks the submission as 'client'.
async function handleInvite(request, env) {
  // Verify the caller is an authenticated advisor
  const authHeader = request.headers.get('Authorization') || ''
  if (!authHeader.startsWith('Bearer ')) {
    return jsonResponse({ error: 'Unauthorized' }, 401)
  }
  const jwt = authHeader.slice(7)

  const userRes = await fetch(`${env.SUPABASE_URL}/auth/v1/user`, {
    headers: { 'Authorization': `Bearer ${jwt}`, 'apikey': env.SUPABASE_ANON_KEY },
  })
  if (!userRes.ok) return jsonResponse({ error: 'Invalid session' }, 401)
  const user = await userRes.json()

  const profileRes = await fetch(
    `${env.SUPABASE_URL}/rest/v1/profiles?id=eq.${user.id}&role=eq.advisor&select=id`,
    { headers: serviceHeaders(env) }
  )
  const advisorProfiles = await profileRes.json()
  if (!Array.isArray(advisorProfiles) || !advisorProfiles.length) {
    return jsonResponse({ error: 'Forbidden — advisor role required' }, 403)
  }

  // Parse request body
  let body
  try { body = await request.json() } catch { return jsonResponse({ error: 'Invalid JSON' }, 400) }
  const { intake_id } = body
  if (!intake_id) return jsonResponse({ error: 'intake_id required' }, 400)

  // Fetch the intake submission
  const intakeRes = await fetch(
    `${env.SUPABASE_URL}/rest/v1/intake_submissions?id=eq.${encodeURIComponent(intake_id)}&select=*`,
    { headers: serviceHeaders(env) }
  )
  const intakes = await intakeRes.json()
  if (!Array.isArray(intakes) || !intakes.length) {
    return jsonResponse({ error: 'Intake submission not found' }, 404)
  }
  const intake = intakes[0]

  if (!intake.email) return jsonResponse({ error: 'Intake submission has no email address' }, 422)

  // Invite the user — Supabase sends them a "set your password" email
  const inviteRes = await fetch(`${env.SUPABASE_URL}/auth/v1/invite`, {
    method: 'POST',
    headers: {
      ...serviceHeaders(env),
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      email: intake.email,
      data: { full_name: fullName(intake.first_name, intake.last_name) },
    }),
  })

  if (!inviteRes.ok) {
    const detail = await inviteRes.text()
    console.error('[invite] Supabase invite failed:', detail)
    return jsonResponse({ error: 'Failed to send invite', detail }, 500)
  }

  const inviteData = await inviteRes.json()
  const userId = inviteData.id

  // Build client_details from intake data
  const client_details = {
    deceased_full_name:   fullName(intake.deceased_first_name, intake.deceased_last_name),
    date_of_death:        intake.date_of_passing || '',
    city_of_death:        intake.city_of_death || '',
    estate_state:         intake.state || '',
    executor_name:        fullName(intake.first_name, intake.last_name),
    executor_email:       intake.email || '',
    executor_phone:       intake.phone || '',
    executor_relationship: intake.relationship || '',
    // executor_address and deceased_date_of_birth are filled in by the client via portal
  }

  // Create the profile (the auth trigger may also create a stub — use upsert)
  await fetch(`${env.SUPABASE_URL}/rest/v1/profiles`, {
    method: 'POST',
    headers: {
      ...serviceHeaders(env),
      'Content-Type': 'application/json',
      'Prefer': 'resolution=merge-duplicates',
    },
    body: JSON.stringify({
      id:             userId,
      full_name:      fullName(intake.first_name, intake.last_name),
      email:          intake.email,
      role:           'client',
      plan:           'guided',
      client_details,
    }),
  })

  // Mark the intake submission as 'client' and link the profile
  await fetch(
    `${env.SUPABASE_URL}/rest/v1/intake_submissions?id=eq.${encodeURIComponent(intake_id)}`,
    {
      method: 'PATCH',
      headers: { ...serviceHeaders(env), 'Content-Type': 'application/json' },
      body: JSON.stringify({ status: 'client', profile_id: userId }),
    }
  )

  return jsonResponse({ success: true, user_id: userId })
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
