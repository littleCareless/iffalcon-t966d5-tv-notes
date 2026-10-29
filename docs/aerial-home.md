# Aerial HOME record

## Result

- Aerial package: `app.orchard.tv`.
- Current installed release observed: official standard v1.69, versionCode 85.
- HOME resolver: `app.orchard.tv/.MainActivity`, marked default.
- After a system reboot, Aerial was captured on screen without an ADB Home-key or app-launch command.
- CyberUI remains installed and enabled for recovery.

## Installation path learned on this device

The Android 14 TCL installer rejected ordinary ADB installation of a HOME-capable APK with a vendor launcher-signature verification failure. The successful procedure used the TV's own MultiScreen installation channel and a temporary, package-specific `app.orchard.tv` exception in the TCL launcher-install strategy. The complete original configuration was saved first; only the package list was changed, and then restored. The owner confirmed each TV-side installation prompt and reboot.

This is an observed method for the stated device and firmware only. The private configuration database/cache backups and write tooling are not included. Do not leave a temporary installation exception in place. The installation exception was restored and checked during the Aerial setup/update work.

## Releases and verification

- Aerial 1.28 standard was installed as the HOME-capable edition after the initial guard setup.
- Later updates through official releases reached v1.46 and then v1.69. The v1.69 record verifies the official APK hash/signer, restored TCL install strategy, package states, HOME resolver and boot target.
- Official project: [Aerial TV releases](https://github.com/pengchujin/aerial-tv/releases).
- The earlier public 1.28 HOME case was also recorded in [Aerial TV issue #420](https://github.com/pengchujin/aerial-tv/issues/420). This repository should add the later debloat and updater-state observations without rewriting that historical result.

## 2026-10-29 Aerial 1.69 adaptation

On the T966D5 / AU01, Home from Aerial and another app passed; standby returned to Aerial 0.7 seconds after wake; reboot first sampled Aerial after 2 seconds, and the owner confirmed it was visible without pressing Home. Aerial listed and opened HDMI 1–4, TV, AV and USB; the owner confirmed the source mapping and HDMI 2 picture. Aerial reported no custom device profile was needed. See [the complete adaptation report](aerial-adapt-T966D5.md) and [full diagnostics](../diagnostics/).

## Limits

The device owner observed Aerial automatically after restart. This does not establish uninterrupted operation over long periods, repeated cold boots, or every power-loss scenario. The HOME and automatic-start result should not be generalized to another TCL model or firmware.
