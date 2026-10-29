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

## 2026-10-29: Aerial 1.46 diagnostic baseline

- Archived the 1.46 `report.sh` snapshot in [`diagnostics/2026-10-29-report-v1.46.md`](../diagnostics/2026-10-29-report-v1.46.md), and the initial and repeat self-tests in the matching 1.46 diagnostic files below.
- Self-test passed the Aerial HomeGuard/default HOME check, Home from Aerial, Home from a third-party app, and the first foreground sample after reboot (Aerial, about one second after boot).
- The first standby run observed `Asleep`; after the 70-second wait and wake, `com.tcl.tv` remained foreground for 60 seconds. A same-version repeat with unchanged settings passed, with Aerial returning 0.6 seconds after wake; behavior was inconsistent on 1.46.
- Signal-source enumeration could not be completed on 1.46: the command returned configuration text instead of JSON, no input was opened, and `INPUTS=1` led to a false `inputs PASS 0 listed`. The 1.46 diagnostics document this parser false positive; the actual input-by-input test was deferred until upgrade.
- Added a redacted visible-message transcript in [`conversation-redacted.md`](conversation-redacted.md). Network addresses and absolute paths are removed; hidden reasoning and tool-internal payloads are excluded.

## 2026-10-29: Aerial 1.69 update and adaptation

- Updated official standard 1.46 (versionCode 49) to 1.69 (versionCode 85) after verifying official hash and matching signer.
- Used the already-authorized temporary single-package launcher-strategy exception, then restored the full original database/cache state. Post-reboot verification matched both byte-for-byte; the installed package inventory and disabled-package state were unchanged.
- Aerial update verification passed for version, HOME, boot target, HomeGuard, notification listener, screensaver settings, app-op settings, package inventory and foreground.
- The owner confirmed after the second update reboot that Aerial appeared without pressing Home. The automated reboot test also first sampled Aerial at 2 seconds.
- Aerial 1.69 selftest passed Home on Aerial, Home from another app, standby wake (0.7 s), reboot, and all seven inputs. The owner confirmed the screen mappings; HDMI 2 displayed the correct connected device. No custom device profile was needed.
- The first Aerial 1.46 run had one standby failure, then a repeat pass without settings changes. Keep this as historical intermittent behavior; this 1.69 pass does not prove long-term reliability.
- Full 1.69 `report.sh` and `selftest.sh` outputs are in [`diagnostics/`](../diagnostics/); the review draft is [`aerial-adapt-T966D5.md`](aerial-adapt-T966D5.md). The Aerial issue was not submitted.
