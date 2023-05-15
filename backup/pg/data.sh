#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR

set -o allexport
source ./.env
set +o allexport
./data.coffee
