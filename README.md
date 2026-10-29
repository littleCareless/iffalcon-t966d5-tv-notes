# IFFALCON / TCL T966D5 TV notes

Device-specific notes for one IFFALCON/TCL T966D5 running Android 14. This repository records the Aerial HOME setup, app installs, a reversible package-disable trial, verification results, and recovery steps.

**This is a single-device case record, not a universal TCL debloat list.** Similar product names and Android versions can use different chipsets, services, and firmware. See [device profile](docs/device-profile.md) before interpreting any result.

## Current recorded state

- Firmware: Android 14 / SDK 34, build `UTT2.250416.001 AU01`.
- Aerial 1.46 is the resolved HOME activity and was observed on screen after reboot without a Home-key command.
- 18 TCL packages are currently disabled with `pm disable-user --user 0`; none were uninstalled or deleted.
- After a reboot, `com.tcl.ffeducation` was updated by TCL's updater and returned to enabled. It was disabled again. That last re-disable has not yet been reboot-tested.
- TV input, FN Video, MultiScreen, the Android Package Installer, Permission Controller, and Aerial HomeGuard were observed enabled after the recorded reboot.

## Contents

- [Device profile and boundaries](docs/device-profile.md)
- [Aerial HOME record](docs/aerial-home.md)
- [Package-disable record and effects](docs/debloat.md)
- [App and TVBox notes](docs/apps-and-tvbox.md)
- [Backup limits and recovery](docs/backup-and-recovery.md)
- [Dated operation log](docs/operation-log.md)
- [Full `report.sh` output](diagnostics/2026-10-29-report.sh.md)
- [Full `selftest.sh` output and correction](diagnostics/2026-10-29-selftest.sh.md)
- [Redacted visible conversation transcript](docs/conversation-redacted.md)
- [Social media research and prepared copy](docs/social-media-kit.md)
- [Re-enable script](scripts/restore-packages.sh)

## Privacy and files intentionally omitted

This repository does not contain the TV's network addresses, serial number, ADB keys, account credentials, full system-settings dumps, TCL configuration database/cache, app data, screenshots, APK files, or the local backup. The diagnostic output includes only selected system fields needed for this case; the customized HDMI-CEC device name, local paths, and network addresses are redacted. The conversation transcript contains visible user/assistant messages only, with network addresses and absolute paths redacted; hidden reasoning and tool-internal payloads are excluded. The local recovery snapshot is incomplete for six protected system/vendor overlays; details are in [backup and recovery](docs/backup-and-recovery.md).

No license is included; reuse rights remain unspecified.
