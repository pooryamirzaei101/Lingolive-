import {supabaseServer} from '@/lib/supabase/server';
import {supabaseConfig} from '@/lib/supabase/config';
export async function POST(request:Request){
 if(!supabaseConfig().enabled)return Response.json({error:'Supabase sign-in is not activated.'},{status:503});
 if(request.headers.get('origin')!==new URL(request.url).origin)return Response.json({error:'Reload the site and try again.'},{status:403});
 try{const body=await request.json() as {action?:string;email?:string;password?:string};const action=body.action;
 if(!['signin','signup','reset','update','signout'].includes(action||''))return Response.json({error:'Choose a valid account action.'},{status:400});
 if(['signin','signup','reset'].includes(action!)&&(typeof body.email!=='string'||body.email.length>254||!/^\S+@\S+\.\S+$/.test(body.email)))return Response.json({error:'Enter a valid email address.'},{status:400});
 if(['signin','signup','update'].includes(action!)&&(typeof body.password!=='string'||body.password.length<8||body.password.length>128))return Response.json({error:'Use a password between 8 and 128 characters.'},{status:400});
 const client=await supabaseServer(),email=body.email?.trim(),password=body.password!,callback=`${new URL(request.url).origin}/auth/supabase/callback`;let error;
 if(action==='signin')({error}=await client.auth.signInWithPassword({email:email!,password}));
 if(action==='signup')({error}=await client.auth.signUp({email:email!,password,options:{emailRedirectTo:callback}}));
 if(action==='reset')({error}=await client.auth.resetPasswordForEmail(email!,{redirectTo:callback+'?next=/auth/supabase?mode=update'}));
 if(action==='update'){const {data,error:identityError}=await client.auth.getUser();if(identityError||!data.user)return Response.json({error:'Open your password reset email or sign in first.'},{status:401});({error}=await client.auth.updateUser({password}))}
 if(action==='signout')({error}=await client.auth.signOut());
 if(error&&action!=='reset')return Response.json({error:error.status===429?'Too many attempts. Please wait before trying again.':action==='signin'?'Sign-in failed. Check your email and password, and confirm your email.':'The account action could not complete. Check the project’s email settings and try again.'},{status:error.status===429?429:400});
 return Response.json({ok:true,message:action==='reset'?'If this email has an account, a reset link will be sent.':action==='signup'?'Check your email to confirm your account, then sign in.':'Account updated.'},{headers:{'Cache-Control':'no-store'}});
 }catch{return Response.json({error:'Account service is temporarily unavailable. Please try again.'},{status:503})}
}
