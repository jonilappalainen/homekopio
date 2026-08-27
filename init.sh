#!/bin/env

SCRIPT_DIR=$(dirname "$0")
source $SCRIPT_DIR/.env

gocryptfs -init $ENCRYPTED_DIR
