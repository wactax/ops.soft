#!/usr/bin/env coffee

> zx/globals:
  @w5/uridir
  path > basename join

PWD = uridir(import.meta)
BAK = join PWD,'bak'

< default main = (uri,dir)=>
  # if not ( uri and uri.endsWith '-dev' )
  #   console.log "数据库名称不包含 -dev 不执行，小心误操作\n#{uri}"
  #   return
  cd "#{BAK}/schema/#{dir}/drop"

  {
    stdout:sql_li
  } = await $"ls *.sql"
  psql = "psql postgres://#{uri}"

  sh = (cmd)=>
    $"sh -c #{cmd}"

  await sh "#{psql} < #{PWD}/extension.sql"

  for sql from sql_li.trim().split '\n'
    schema = basename(sql).slice(0,-4)
    if schema != 'public'
      await sh """#{psql} -c "DROP SCHEMA #{schema} CASCADE" || true"""
    await sh "#{psql} < #{sql}"
    await sh "zstd -qcd #{BAK}/data/#{dir}/#{schema}.zstd | pg_restore --disable-triggers -d 'postgres://#{uri}'"
  return

if process.argv[1] == decodeURI (new URL(import.meta.url)).pathname
  for i in 'art apg'.split(' ')
    uri = process.env[i.toUpperCase()+'_URI']
    if uri
      await main(uri,i+'-ol')
  process.exit()

