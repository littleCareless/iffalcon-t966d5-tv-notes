# Reversible package-disable record

## Method and current state

The packages below were disabled in several small batches with `pm disable-user --user 0`. They remain installed on the TV. No `pm uninstall`, data wipe, root operation, or firmware flash was used. The initial disabled-package snapshot was empty.

```text
com.tcl.bootadservice
com.tcl.wholenetsearch
com.tcl.playskill
com.tcl.useragreement
com.tcl.appreciate.art
com.tcl.c2dm.client
com.tcl.logkit
com.tcl.usercenter
com.tcl.ttvs
com.tcl.guard
com.tcl.profilemanager
com.tcl.xian.StartandroidService
com.tcl.atomic.servicecenter
com.tcl.repairguide
com.tcl.ffeducation
com.tcl.hotelmenu
com.tcl.vod
com.tcl.walleve
```

## Effects and uncertainty

| Package | Intended effect / observed impact |
| --- | --- |
| `com.tcl.bootadservice` | Boot advertising. |
| `com.tcl.wholenetsearch` | TCL whole-network search promotions; stock search may be reduced. |
| `com.tcl.playskill` | TCL tips/promotional content. |
| `com.tcl.useragreement` | TCL agreement prompts may stop. |
| `com.tcl.appreciate.art` | The configured stock art/screensaver service is disabled; stock art screensaver is unavailable. |
| `com.tcl.c2dm.client` | TCL push connection/notifications may stop. |
| `com.tcl.logkit` | TCL log collection/upload may stop; Android system logging is separate. |
| `com.tcl.usercenter` | TCL account/VIP/cloud-dependent features may stop. |
| `com.tcl.ttvs` | Several TCL services were observed before disabling. Its full scope on this firmware is not established. |
| `com.tcl.guard` | TCL TV Guardian/permission UI is disabled. USB installation through that app may be unavailable; MultiScreen and ADB remained available. |
| `com.tcl.profilemanager` | Treated as a profile/reporting candidate based on a nearby TCL Android 14 example; exact T966D5 behavior is not independently confirmed. |
| `com.tcl.xian.StartandroidService` | Treated as a background-reporting candidate based on a nearby example; exact T966D5 behavior is not independently confirmed. |
| `com.tcl.atomic.servicecenter` | Recommendation/service-center entry disabled. |
| `com.tcl.repairguide` | TCL repair-guide app disabled. |
| `com.tcl.ffeducation` | Education/kids content disabled. TCL's updater later updated this package and reset it to enabled; it was manually disabled again. |
| `com.tcl.hotelmenu` | Hotel-mode UI disabled. |
| `com.tcl.vod` | TCL VOD service disabled; its previously running service exited. TCL VOD playback has not been retested. |
| `com.tcl.walleve` | TCL voice/AI accessibility package disabled. Its accessibility service was removed; Aerial HomeGuard remained enabled. TCL voice remote/search is expected to stop and has not been retested. |

## Verification

After the 18-package trial, one reboot completed (`sys.boot_completed=1`). Aerial was the top-resumed activity and appeared in a screen capture without a Home-key command. `AUTO_START` and `ASSOC_START` remained allowed. `com.tcl.tv`, `com.tcl.tvinput`, MultiScreen, FN Video (`com.trim.tv`), Android Package Installer, and Permission Controller remained enabled. The TV input service was present and Wi-Fi ADB reconnected.

After that reboot, TCL's `com.tcl.versionUpdateApp` installed a newer `com.tcl.ffeducation` package (`6.2.006_master_6`, installer `com.tcl.versionUpdateApp`, update time 2026-10-29 17:15:55), which returned it to enabled. It was disabled again. This last re-disable is not yet reboot-tested. This observed update behavior means a package update can reset a package's disabled state.

RAM snapshots varied. One pair showed `MemAvailable` moving from about 1.06 GB to 1.13 GB, but this is not a controlled benchmark and should not be attributed entirely to package disabling.

## Kept enabled

CyberUI fallback HOME, Android System UI, Settings, Package Installer, Permission Controller, TCL system server/config provider, TV and HDMI input services, MultiScreen (used for the TV's app-push workflow), Sogou TV keyboard, Bluetooth/remote pairing, and update services. The user may choose to review optional OTA or casting functions separately; no updater, Miracast, app-store, USB Media Center, keyboard, or fallback HOME package is disabled here.

## External reference

The FFALCON/TCL T982 Android 11 list and the CleanYourTV TCL Android 14 examples informed candidate discovery, but this device uses Amlogic `t6x`, has about 2 GB RAM, and has its own firmware behavior. Those package lists are not proof of compatibility. See [CleanYourTV's contribution guidance](https://github.com/Gathin23/cleanyourtv/blob/main/CONTRIBUTING.md) before reusing a list on any other model.
