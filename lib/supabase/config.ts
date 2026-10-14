import {env} from 'cloudflare:workers';
export function supabaseConfig(){const settings=env as unknown as Record<string,string|undefined>;return {enabled:settings.AUTH_PROVIDER==='supabase',url:settings.SUPABASE_URL||'',key:settings.SUPABASE_PUBLISHABLE_KEY||''}}
export function safeAuthReturn(value:string|null){return value?.startsWith('/')&&!value.startsWith('//')&&!value.includes('\\')&&!value.startsWith('/auth/')?value:'/account'}
