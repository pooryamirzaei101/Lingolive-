import {SupabaseLogin} from '@/components/supabase-login';
import {supabaseConfig} from '@/lib/supabase/config';
export const dynamic='force-dynamic';
export default async function Page({searchParams}:{searchParams:Promise<{mode?:string;error?:string}>}){const params=await searchParams;if(!supabaseConfig().enabled)return <section className="section shell"><h1>Supabase setup</h1><p>This login integration is prepared but has not been activated. Continue using your existing account.</p><a href="/account">My account</a></section>;return <section className="section shell"><SupabaseLogin initialMode={['signup','reset','update','signout'].includes(params.mode||'')?params.mode:'signin'} initialError={!!params.error}/></section>}
