import {PGlite} from '@electric-sql/pglite';
import fs from 'node:fs';
import assert from 'node:assert/strict';
const db=new PGlite();await db.exec('CREATE ROLE anon; CREATE ROLE authenticated; CREATE ROLE service_role BYPASSRLS;');
await db.exec(fs.readFileSync('supabase/migrations/202610130001_initial_private_schema.sql','utf8'));
const tables=await db.query("SELECT tablename,rowsecurity FROM pg_tables WHERE schemaname='app_private'");assert.equal(tables.rows.length,35);assert.ok(tables.rows.every(t=>t.rowsecurity));
await db.exec('SET ROLE anon;');await assert.rejects(()=>db.query('SELECT * FROM app_private.media_integrations'),/permission denied/);await db.exec('RESET ROLE; SET ROLE authenticated;');await assert.rejects(()=>db.query('SELECT * FROM app_private.speaking_recordings'),/permission denied/);await db.exec('RESET ROLE; SET ROLE service_role;');await db.query('SELECT * FROM app_private.video_lessons');await db.close();console.log('PASS: 35 PostgreSQL tables, all RLS enabled; anonymous and student roles denied private data; server role allowed. No live database changed.');
