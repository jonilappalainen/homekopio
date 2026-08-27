#!/bin/env

SCRIPT_DIR=$(dirname "$0")
ENVFILE=${1:-$SCRIPT_DIR/.env}
source $ENVFILE

gocryptfs -init $ENCRYPTED_DIR
