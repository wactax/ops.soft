#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR

source .env && PG_URI=$NN_URI ./data.coffee
