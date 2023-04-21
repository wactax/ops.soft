#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -ex

source .env

if [[ $NN_URI != *_dev* ]]; then
  echo "数据库名称不包含 _dev 不执行，小心误操作"
  exit 0
fi

load_schema() {
  psql postgres://$1 -c "DROP SCHEMA $2 CASCADE" || true
  # psql postgres://$1 <./dump/xxai.art/ol/table/$2.sql
  # psql postgres://$1 <./data/ol/$2.sql

  #zstd -qcd
  # pg_restore postgres://$1 -d $1 ./data/ol/$1.tar
}

load() {
  load_schema $1 bot
  load_schema $1 img
}

load $PG_URI
# load $NN_URI
