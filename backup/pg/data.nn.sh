#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR

PG_URI=$NN_URI ./data.coffee
