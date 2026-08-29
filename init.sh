#!/usr/bin/env bash

set -e

SCRIPT_DIR=$(dirname "$0")
ENVFILE=${1:-$SCRIPT_DIR/.env}
source $ENVFILE

echo "Initializing '$ENCRYPTED_DIR'"
gocryptfs -init $ENCRYPTED_DIR
