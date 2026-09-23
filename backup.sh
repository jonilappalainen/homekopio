#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "$0")
ENVFILE=${1:-$SCRIPT_DIR/.env}
source $ENVFILE
is_mounted=false

mkdir $MOUNT_DIR

if [ "$USE_GOCRYPT" = "true" ]; then
  # mount
  GOCRYPTFS="$ENCRYPTED_DIR/gocryptfs.conf"
  if [ ! -f "$GOCRYPTFS" ]; then
    echo "Cannot find $GOCRYPTFS"
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
  is_mounted=true
else
  is_mounted=true
fi

echo "is_mounted $is_mounted"
# backup
if [ $is_mounted = "true" ] && [ -d "$MOUNT_DIR" ]; then
  # --archive, -a            archive mode is -rlptgoD (no -A,-X,-U,-N,-H)
  # --verbose, -v            increase verbosity
  # --compress, -z           compress file data during the transfer
  # --recursive, -r          recurse into directories
  # --copy-links, -L         transform symlink into referent file/directory
  # --perms, -p              preserve permissions
  rsync -avzrLp --copy-links --safe-links --delete --delete-excluded --files-from="$INCLUDES_FILE" --exclude-from="$EXCLUDES_FILE" $SOURCE_DIR $MOUNT_DIR
else
  echo "invalid target/mount dir $MOUNT_DIR"
fi

if [ "$USE_GOCRYPT" = "true" ] && [ $is_mounted = "true" ]; then
  # unmount
  echo "umounting $MOUNT_DIR"
  fusermount -u $MOUNT_DIR
fi
