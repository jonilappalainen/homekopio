#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "$0")
source $SCRIPT_DIR/.env

GOCRYPTFS="${ENCRYPTED_DIR}/gocryptfs.conf"
if [ ! -f "$GOCRYPTFS" ]; then
  echo "Invalid crypt dir"
  exit 1
fi

if [ ! -d "$MOUNT_DIR" ]; then
  mkdir $MOUNT_DIR
fi

gocryptfs $ENCRYPTED_DIR $MOUNT_DIR
