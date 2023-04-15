#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -ex

source ../../../docker/wac/env

psql postgres://$PG_URI <dump/user.tax/drop/public.sql
psql postgres://$PG_URI <dump/user.tax/drop/auth_mail.sql
psql postgres://$PG_URI <dump/user.tax/drop/u.sql
