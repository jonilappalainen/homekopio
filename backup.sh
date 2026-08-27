#!/usr/bin/env bash

set -e

SCRIPT_DIR=$(dirname "$0")
ENVFILE=${1:-$SCRIPT_DIR/.env}
source $ENVFILE

# mount
GOCRYPTFS="$ENCRYPTED_DIR/gocryptfs.conf"
if [ ! -f "$GOCRYPTFS" ]; then
  echo "Invalid ENCRYPTED_DIR $ENCRYPTED_DIR"
  exit 1
fi

if [ ! -d "$MOUNT_DIR" ]; then
  echo "Invalid MOUNT_DIR $MOUNT_DIR"
  exit 1
fi

if ! mountpoint -q "$MOUNT_DIR"; then
  gocryptfs $ENCRYPTED_DIR $MOUNT_DIR
else
  echo "Already mounted at $MOUNT_DIR"
fi

# backup
if [ -d "$MOUNT_DIR" ]; then
  # --archive, -a            archive mode is -rlptgoD (no -A,-X,-U,-N,-H)
  # --verbose, -v            increase verbosity
  # --compress, -z           compress file data during the transfer
  # --recursive, -r          recurse into directories
  # --copy-links, -L         transform symlink into referent file/directory
  # --perms, -p              preserve permissions
  rsync -avzrLp --delete --delete-excluded --files-from="$INCLUDES_FILE" --exclude-from="$EXCLUDES_FILE" $SOURCE_DIR $MOUNT_DIR

else
  echo "invalid target/mount dir $MOUNT_DIR"
fi

# unmount
fusermount -u $MOUNT_DIR
