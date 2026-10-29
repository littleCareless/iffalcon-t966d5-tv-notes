# Device profile

Observed on 2026-10-29 through the owner's authorized Wi-Fi ADB connection.

| Field | Observed value |
| --- | --- |
| 商品型号 | 雷鸟鹤 6 Ultra，2027 款，85 英寸（设备所有者提供；未由 Android 属性独立核验） |
| Retail brand | IFFALCON / TCL |
| UI model | TCL Smart TV Pro |
| Product name | `T966D5_4K_CN` |
| Device | `T966D5` |
| Board platform / hardware | `t6x` / `amlogic` |
| Android | 14 / SDK 34 |
| Build | `UTT2.250416.001`, `AU01`, user/release-keys |
| RAM | About 2 GB |
| ABI | 32-bit ARM (`armeabi-v7a`) |
| Original HOME | `com.tcl.cyberui/.MainActivity` |
| Current HOME | `app.orchard.tv/.MainActivity` (Aerial 1.46, versionCode 49) |

The full build fingerprint is `TCL/T966D5_4K_CN/T966D5:14/UTT2.250416.001/AU01:user/release-keys`. Network addresses and device identifiers are intentionally omitted.

The marketed model above is the owner's identification of this television. Android reports the device as `T966D5` / `T966D5_4K_CN`; this repository keeps the retail model separate from the firmware-reported identifiers because they describe different layers and should not be conflated.

## Scope

- All package changes in this record use Android's reversible `pm disable-user --user 0` state.
- No original APK was uninstalled, deleted, or overwritten during the package-disable work.
- CyberUI remains installed and enabled as the fallback HOME.
- Aerial's `AUTO_START` operation remained allowed after the recorded reboot. Aerial HomeGuard remained the enabled accessibility service after Walleve was disabled.
- One reboot was observed after all 18 packages were disabled. Later, the TCL updater updated `com.tcl.ffeducation` and re-enabled it; it was disabled again, without a subsequent reboot test.
