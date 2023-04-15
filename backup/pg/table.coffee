#!/usr/bin/env coffee

> zx/globals:
  @w5/uridir
  @w5/write
  @w5/read
  @w5/pg/PG > LI0
  path > join

ROOT = uridir(import.meta)

{PG_URI} = process.env

DATA = join(ROOT, 'dump')

_dump = (schema,args,dir)=>
  sql = "#{DATA}/#{dir}/#{schema}.sql"
  await $"pg_dump postgres://#{PG_URI} #{args.split(' ')} -s -n #{schema} -f #{sql}"

  li = read(sql).split('\n').filter(
    (i)=>
      not i.startsWith('--')
  )
  write(sql,li.join('\n'))
  return

dump = (schema)=>
  args = '--no-owner --no-acl'
  await Promise.all [
    _dump(schema, args, 'table')
    _dump(schema, args + ' --if-exists --clean', 'drop')
  ]
  return

< default main = =>

  if not PG_URI
    console.log 'miss PG_URI'
    return

  li = PG_URI.split('/')


  DATA = join DATA,li[0].split(':')[0]+'/'+li.pop().split('?')[0]

  await Promise.all [
    $"mkdir -p #{DATA}/table"
    $"mkdir -p #{DATA}/drop"
  ]

  await Promise.all(
    (
      await LI0"SELECT schema_name FROM information_schema.schemata WHERE schema_name NOT LIKE 'pg_%' AND schema_name != 'information_schema'"
    ).map(dump)
  )
  return

if process.argv[1] == decodeURI (new URL(import.meta.url)).pathname
  await main()
  process.exit()

