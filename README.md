
Backup and crypt your home dir or any other dir. You can give a list of files/dirs to backup and list of excludes to not backup.


## Install

Requires gocryptfs and rsync.

## Usage:

Setup the environment variables in .env and "files" and "excludes"

```
# init (only once)
init.sh

# mount to decrypt
mount.sh

# backup home (except excludes)
backup.sh

# unmount to stop using
umount.sh
```

