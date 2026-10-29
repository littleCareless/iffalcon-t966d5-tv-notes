# Aerial HOME record

## Result

- Aerial package: `app.orchard.tv`.
- Current installed release observed: official standard v1.46, versionCode 49.
- HOME resolver: `app.orchard.tv/.MainActivity`, marked default.
- After a system reboot, Aerial was captured on screen without an ADB Home-key or app-launch command.
- CyberUI remains installed and enabled for recovery.

## Installation path learned on this device

The Android 14 TCL installer rejected ordinary ADB installation of a HOME-capable APK with a vendor launcher-signature verification failure. The successful procedure used the TV's own MultiScreen installation channel and a temporary, package-specific `app.orchard.tv` exception in the TCL launcher-install strategy. The complete original configuration was saved first; only the package list was changed, and then restored. The owner confirmed each TV-side installation prompt and reboot.

This is an observed method for the stated device and firmware only. The private configuration database/cache backups and write tooling are not included. Do not leave a temporary installation exception in place. The installation exception was restored and checked during the Aerial setup/update work.

## Releases and verification

- Aerial 1.28 standard was installed as the HOME-capable edition after the initial guard setup.
- Later updates through official releases culminated in v1.46. The local record verified the official APK signature against the installed app and checked the resulting package version and HOME resolver.
- Official project: [Aerial TV releases](https://github.com/pengchujin/aerial-tv/releases).
- The earlier public 1.28 HOME case was also recorded in [Aerial TV issue #420](https://github.com/pengchujin/aerial-tv/issues/420). This repository should add the later debloat and updater-state observations without rewriting that historical result.

## Limits

The device owner observed Aerial automatically after restart. This does not establish uninterrupted operation over long periods, repeated cold boots, or every power-loss scenario. The HOME and automatic-start result should not be generalized to another TCL model or firmware.
