#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "$0")
ENVFILE=${1:-$SCRIPT_DIR/.env}
source $ENVFILE

fusermount -u $MOUNT_DIR

