#!/usr/bin/env coffee

> zx/globals:
  @w5/uridir
  @w5/pg/PG > LI0
  path > join

ROOT = uridir(import.meta)

{PG_URI} = process.env

DATA = join(ROOT, 'data')

dump = (schema)=>
  await $"pg_dump postgres://#{PG_URI} --data-only -n #{schema} -Fc -Z0 | zstd > #{DATA}/#{schema}.zstd"
  return

< default main = =>

  if not PG_URI
    console.log 'miss PG_URI'
    return

  db = PG_URI.split('/').pop().split('?')[0]

  DATA = join DATA,db

  await $"mkdir -p #{DATA}"

  for i from await LI0"SELECT schema_name FROM information_schema.schemata WHERE schema_name NOT LIKE 'pg_%' AND schema_name != 'information_schema'"
    await dump(i)

  return

if process.argv[1] == decodeURI (new URL(import.meta.url)).pathname
  await main()
  process.exit()

