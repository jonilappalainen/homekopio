#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "$0")
source $SCRIPT_DIR/.env

fusermount -u $MOUNT_DIR

