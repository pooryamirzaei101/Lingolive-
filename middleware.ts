import {NextResponse,type NextRequest} from 'next/server';
import {createServerClient} from '@supabase/ssr';
import {supabaseConfig} from '@/lib/supabase/config';
export async function middleware(request:NextRequest){const config=supabaseConfig();let response=NextResponse.next({request});if(!config.enabled||!config.url||!config.key)return response;const client=createServerClient(config.url,config.key,{cookies:{getAll:()=>request.cookies.getAll(),setAll:values=>{for(const {name,value} of values)request.cookies.set(name,value);response=NextResponse.next({request});for(const {name,value,options} of values)response.cookies.set(name,value,{...options,httpOnly:true,secure:true,sameSite:'lax',path:'/'})}}});try{await client.auth.getUser()}catch{}return response}
export const config={matcher:['/((?!_next/static|_next/image|favicon.ico|.*\\.(?:png|jpg|jpeg|gif|svg|webp|mp4|mp3)$).*)']};
