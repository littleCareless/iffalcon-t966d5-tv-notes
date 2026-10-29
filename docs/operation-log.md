# Operation log

Dates use China Standard Time. This is a single device's running record; not every test was repeated after every package update.

## 2026-10-22 to 2026-10-24: Aerial HOME and app setup

- Documented a reversible method to install official Aerial standard through the TV's MultiScreen channel after a temporary package-specific launcher exception. The exception was restored.
- Aerial was set as default HOME. A later official update reached v1.46 (versionCode 49, SHA-256 `73e6328507515af7a0a8d8569c2d2e4a83da0229fc4b6e6a3d9a51198e303e30`).
- The owner confirmed automatic entry into Aerial after reboot without pressing Home. Screenshots/logs show Aerial after boot; long-duration stability is not claimed.
- FN Video was installed and opened. FN Music was later removed by the owner.
- TVBox source import returned `ok`; all source URLs and playback were not individually validated.

## 2026-10-29: backup and package-disable trials

- Captured settings/state and APKs before changes. Six protected overlay APKs were unreadable as detailed in [backup and recovery](backup-and-recovery.md).
- Disabled the first 10 packages, then rebooted and verified Aerial.
- Disabled 8 more packages. Aerial remained foreground immediately after each command, and critical input/install/MultiScreen packages remained enabled.
- Rebooted after all 18 were disabled. Android completed boot, Aerial was on screen without a Home command, and all 18 were initially reported disabled.
- TCL's updater then updated FF Education at 17:15:55 and re-enabled it. It was disabled again; this final re-disable has not been followed by another reboot.
- No package uninstall, data clear, root, or firmware flash was performed.
