# LingoLive — Supabase preparation (stage 1)

## What is ready

- PostgreSQL setup for all 35 current application tables.
- Server-private schema with row-level security and no access for anonymous or authenticated browser roles. Provider credentials, support messages, memberships and recordings are not publicly exposed.
- Optional email/password signup, sign-in, confirmation, password recovery, sign-out and server-validated identity.
- HttpOnly, Secure, SameSite cookies; session refresh middleware; same-origin account mutations; generic authentication errors.
- Supabase is disabled by default. Current Sites/D1/R2 and ChatGPT accounts continue unchanged.

## Owner action — database setup only

1. In the Supabase project, open **SQL Editor → New query**.
2. Copy the complete contents of `supabase/migrations/202610130001_initial_private_schema.sql` from this repository, paste it, and press **Run** once. Do not edit it.
3. Tell the developer whether it succeeded, or send the error text. Do not send passwords or secret keys.

This creates empty tables in `app_private`. It does not copy current lessons, recordings, users or API credentials. The tables will not appear in the default `public` schema view. Do not add `app_private` to the exposed Data API schemas.

## Developer activation checklist — not an owner coding task

Do not switch the live app yet. Before activation:

1. Complete the PostgreSQL data-access adapter. Current routes still use Drizzle SQLite/D1-specific queries and transactions. Merely running the SQL does not connect those routes to PostgreSQL.
2. Export/import records and map existing ChatGPT account IDs to verified Supabase accounts. Preserve Word Bank, saved sentences, learning progress, premium expiry dates, support and referral records. Do not link accounts using unverified email or user metadata.
3. Choose storage for existing 100 MB media; Supabase Free has a 50 MB file-size cap. Existing R2 files remain untouched. Do not make recordings publicly readable.
4. Configure a server-only database connection through the hosting provider's secret settings. Never place a database password or service-role key in browser code or GitHub.
5. Keep the existing credential encryption key when migrating encrypted provider settings.
6. In Supabase **Authentication → URL Configuration**, set the deployment origin as Site URL and allow its exact `/auth/supabase/callback` URL, including the password-recovery callback query. Enable email verification and configure SMTP delivery. Test confirmations and recovery on the final deployment.
7. Set the server-only `ADMIN_EMAIL` to the owner's verified email; it is never taken from signup metadata. A second ordinary account must fail every administration operation.
8. Configure the optional auth settings below only on a staging deployment first. Test login, refresh, signout, reset, permissions, saved data and media before switching production.

```
AUTH_PROVIDER=supabase
SUPABASE_URL=https://ilizebjsniveoounrviv.supabase.co
SUPABASE_PUBLISHABLE_KEY=<the supplied publishable key>
ADMIN_EMAIL=<owner verified email>
```

Until those checks pass, leave `AUTH_PROVIDER` unset. Without it the existing account path is retained. No new paid service has been activated.

## Validation

```
python scripts/generate-supabase-schema.py
node scripts/tests/supabase-schema.mjs
node scripts/tests/supabase-auth.cjs
npx tsc --noEmit
npm run build
```

Tests use isolated PostgreSQL and mocked Auth. Live signup/email/storage have not been tested without a connected staging deployment.
