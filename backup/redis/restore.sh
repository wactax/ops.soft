#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -ex

load() {
  rclone lsjson $RCLONE_BAK/$1 | jq -r ".[].Name" | tail -1
  # redis-cli -h 127.0.0.1 -p 9970 -a $REDIS_PASSWORD --pipe $1
}

load KV
