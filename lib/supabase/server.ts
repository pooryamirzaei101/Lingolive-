import {createServerClient} from '@supabase/ssr';
import {cookies} from 'next/headers';
import {supabaseConfig} from './config';
export async function supabaseServer(){const config=supabaseConfig();if(!config.enabled||!config.url||!config.key)throw Error('Supabase sign-in is not configured.');const jar=await cookies();return createServerClient(config.url,config.key,{cookies:{getAll:()=>jar.getAll(),setAll:values=>{for(const {name,value,options} of values)jar.set(name,value,{...options,httpOnly:true,secure:true,sameSite:'lax',path:'/'})}}})}
export async function supabaseIdentity(){try{const client=await supabaseServer();const {data,error}=await client.auth.getUser();const user=data.user;if(error||!user?.email||!user.email_confirmed_at)return null;const fullName=typeof user.user_metadata?.full_name==='string'?user.user_metadata.full_name:null;return {userId:user.id,email:user.email,displayName:fullName||user.email,fullName}}catch{return null}}
