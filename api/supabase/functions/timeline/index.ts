import "https://esm.sh/@supabase/functions-js/src/edge-runtime.d.ts"
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

Deno.serve(async (req) => {
  const supaURL: string | undefined = Deno.env.get("SUPABASE_URL")
  const supaAnonKey: string | undefined = Deno.env.get("SUPABASE_URL")
  let supabase: any
  if (supaURL !== undefined && supaAnonKey !== undefined) {
    supabase = createClient(supaURL, supaAnonKey)
  }

  // user情報を取得
  // ----------- apiを叩いたuser情報を取得する方法がわからなかった ---------------
  // const { user, error } = await supabase.auth.refreshSession()
  // const user = await supabase.auth.getUser()
  // console.log(user)
  // urlからクエリパラメータを取得
  const url = new URL(req.url);
  const params = new URLSearchParams(url.search);
  const sortedBy = params.get('sortedBy')
  const orderBy = params.get('orderBy')
  let audios: any

  if (sortedBy !== null) {
    const ascending = orderBy !== 'asc' ? true : false

    audios = await supabase
      .from('audios')
      .select('*')
      .order(sortedBy, {ascending: ascending})
  } else {
    audios = await supabase
      .from('audios')
      .select('*')
  }

  // ★デバック
  console.log(audios)

  return new Response(
    JSON.stringify(audios),
    { headers: { "Content-Type": "application/json" } },
  )
})

/* To invoke locally:

  1. Run `supabase start` (see: https://supabase.com/docs/reference/cli/supabase-start)
  2. Make an HTTP request:

  curl -i --location --request POST 'http://127.0.0.1:54321/functions/v1/timeline' \
    --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0' \
    --header 'Content-Type: application/json' \
    --data '{"name":"Functions"}'

*/
