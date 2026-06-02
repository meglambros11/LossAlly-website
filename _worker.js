export default {
  async fetch(request, env) {
    const response = await env.ASSETS.fetch(request)

    // Only transform HTML responses
    const contentType = response.headers.get('content-type') || ''
    if (!contentType.includes('text/html')) {
      return response
    }

    // Inject env vars as the very first script inside <head>
    // so they're available before any other scripts execute.
    const snippet = `<script>` +
      `window.SUPABASE_URL=${JSON.stringify(env.SUPABASE_URL || '')};` +
      `window.SUPABASE_ANON_KEY=${JSON.stringify(env.SUPABASE_ANON_KEY || '')};` +
      `</script>`

    const html = await response.text()
    const injected = html.replace('<head>', `<head>${snippet}`)

    // Rebuild headers without Content-Length (body size changed)
    const headers = new Headers(response.headers)
    headers.delete('content-length')

    return new Response(injected, {
      status: response.status,
      statusText: response.statusText,
      headers,
    })
  },
}
