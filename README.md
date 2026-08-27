
Backup and crypt your home dir or any other dir. You can give a list of files/dirs to backup and list of excludes to not backup.


## Install

Requires gocryptfs and rsync.

## Usage:

Setup the environment variables in .env and "files" and "excludes". You can also give the env file as parameter. The env file has path to files and excludes.

```
# init (only once)
init.sh [path/to/.env]

# mount to decrypt
mount.sh [path/to/.env]

# backup home (except excludes)
backup.sh [path/to/.env]

# unmount to stop using
umount.sh [path/to/.env]
```

