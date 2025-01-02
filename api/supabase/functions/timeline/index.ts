import "https://esm.sh/@supabase/functions-js/src/edge-runtime.d.ts"
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

Deno.serve(async (req) => {
  const supaURL: string | undefined = Deno.env.get("SUPABASE_URL")
  const supaAnonKey: string | undefined = Deno.env.get("SUPABASE_ANON_KEY")

  let supabase: any
  if (supaURL !== undefined && supaAnonKey !== undefined) {
    supabase = createClient(supaURL, supaAnonKey)
  }

  // user情報を取得
  let token = req.headers.get('authorization')
  if (token != null) {
    token = token.split('Bearer ')[1];
  }

  // Requestから情報を取得する
  const userInfo = await supabase.auth.getUser(token);
  const url = new URL(req.url)
  const params = new URLSearchParams(url.search)
  const sortedBy = params.get('sortedBy')
  const orderBy = params.get('orderBy')
  let audios: any

  if (sortedBy !== null) {
    const ascending = orderBy !== 'asc' ? true : false

    audios = await supabase
      .from('audios')
      .select('*')
      .neq('created_by', userInfo.data.user.id)
      .order(sortedBy, {ascending: ascending})
  } else {
    audios = await supabase
      .from('audios')
      .select('*')
      .neq('created_by', userInfo.data.user.id)
  }

  return new Response(
    JSON.stringify(audios),
    { headers: { "Content-Type": "application/json" } },
  )
})