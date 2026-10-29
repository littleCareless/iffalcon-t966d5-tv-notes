# Backup and recovery

## Local snapshot

Before package changes, the local machine captured 16 settings/device-state snapshots and pulled 151 APKs for 157 enumerated package names. The copied APKs were SHA-256 checked. Six protected vendor/system overlay APKs could not be read by the unprivileged ADB shell. There was no root access, full partition image, or user-data backup.

This snapshot is a useful local recovery aid, **not a complete firmware backup**. It remains on the owner's computer and is not committed here. The TV's settings exports and TCL configuration database/cache may reveal private configuration and must stay local.

## Re-enable packages

Run `scripts/restore-packages.sh` with an ADB binary, this TV's current ADB serial, and the ADB server port. The script enables the 18 packages above and re-adds Walleve's accessibility component while preserving services currently enabled (including Aerial HomeGuard).

```sh
ADB=/path/to/adb ADB_SERVER_PORT=5038 TV_SERIAL=TV_ADDRESS:5555 ./scripts/restore-packages.sh
```

The script has not been run against the TV because that would undo the requested configuration. It passed a local POSIX shell syntax check. After running it, inspect the script output, package-disabled list, accessibility service list, and HOME behavior.
