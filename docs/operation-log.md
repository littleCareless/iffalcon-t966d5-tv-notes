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

## 2026-10-29: Aerial diagnostic self-test

- Archived the full sanitized `report.sh` output and full `selftest.sh` output in [`diagnostics/`](../diagnostics/).
- Self-test passed the Aerial HomeGuard/default HOME check, Home from Aerial, Home from a third-party app, and the first foreground sample after reboot (Aerial, about one second after boot).
- Standby test observed `Asleep`; after the 70-second wait and wake, `com.tcl.tv` remained foreground for the next 60 seconds. Aerial did not return automatically during that interval.
- Signal-source enumeration could not be completed: Aerial 1.46 returned a settings string instead of the JSON source list expected by the script. No input was opened. The script's resulting `inputs PASS 0 listed` is a false positive and is corrected in the diagnostic note.
- Added a redacted visible-message transcript in [`conversation-redacted.md`](conversation-redacted.md). Network addresses and absolute paths are removed; hidden reasoning and tool-internal payloads are excluded.
