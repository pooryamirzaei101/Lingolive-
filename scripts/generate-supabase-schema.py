"""Generate a reviewed, server-private PostgreSQL schema from the D1 migrations."""
import sqlite3,pathlib,re
root=pathlib.Path(__file__).resolve().parents[1]
db=sqlite3.connect(':memory:')
for migration in sorted((root/'drizzle').glob('*.sql')):db.executescript(migration.read_text())
statements=[]
for kind,name,sql in db.execute("select type,name,sql from sqlite_master where sql is not null and name not like 'sqlite_%' and type in ('table','index') order by case type when 'table' then 0 else 1 end,name"):
 sql=sql.replace('`','"')
 sql=re.sub(r'\bINTEGER\b','BIGINT',sql,flags=re.I)
 sql=re.sub(r'(CREATE TABLE )("?\w+"?)',r'\1app_private.\2',sql,flags=re.I)
 sql=re.sub(r'( ON )("?\w+"?)',r'\1app_private.\2',sql,flags=re.I)
 statements.append(sql+';')
 if kind=='table':statements.extend([f'ALTER TABLE app_private."{name}" ENABLE ROW LEVEL SECURITY;',f'ALTER TABLE app_private."{name}" FORCE ROW LEVEL SECURITY;'])
header='''-- LingoLive stage 1: schema only. No current data or API keys are copied.
-- Server-private tables: the public API cannot query this schema.
BEGIN;
CREATE SCHEMA IF NOT EXISTS app_private;
REVOKE ALL ON SCHEMA app_private FROM PUBLIC, anon, authenticated;
GRANT USAGE ON SCHEMA app_private TO service_role;
'''
footer='''
REVOKE ALL ON ALL TABLES IN SCHEMA app_private FROM PUBLIC, anon, authenticated;
GRANT ALL ON ALL TABLES IN SCHEMA app_private TO service_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA app_private REVOKE ALL ON TABLES FROM PUBLIC, anon, authenticated;
COMMIT;
'''
(root/'supabase/migrations/202610130001_initial_private_schema.sql').write_text(header+'\n\n'.join(statements)+footer)
print(f'Generated {sum(1 for s in statements if s.startswith("CREATE TABLE"))} PostgreSQL tables.')
