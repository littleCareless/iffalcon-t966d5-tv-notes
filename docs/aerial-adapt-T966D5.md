# Aerial device adaptation report: IFFALCON/TCL T966D5

Prepared 2026-10-29 from the official diagnostic scripts, an update to Aerial 1.69 standard, and owner-confirmed screen observations. Submitted to the Aerial project as [issue #885](https://github.com/pengchujin/aerial-tv/issues/885) on 2026-10-29.

Privacy: the locally customized HDMI-CEC name is redacted. The report contains no TV IP, ADB key, account data, serial number, screenshots, APKs, or absolute host paths.

## Device and adaptation request

- Brand/product: IFFALCON / TCL; owner-described product is 雷鸟鹤 6 Ultra 2027 款 85 英寸. The system reports model `Smart TV Pro`, device `T966D5`, product `T966D5_4K_CN`.
- Aerial version in this report: official standard 1.69, versionCode 85.
- Related upstream reports: [#420](https://github.com/pengchujin/aerial-tv/issues/420) documents this owner-described 85-inch product on an earlier Aerial version; [#817](https://github.com/pengchujin/aerial-tv/issues/817) documents a different retail model with the same `T966D5` device/build but a HomeGuard startup problem. This report adds current 1.69 standard, standby, reboot, and input results for the 85-inch product and should be treated as supplementary device evidence.
- Owner's request: “读 adapt.md，给我的电视做 Aerial 适配。” The prior device issue was that TCL's desktop-install verification rejected an alternative launcher. The owner asked whether the successful whitelist procedure was specific to this unit: “但是这个问题我们解决了，不过我不清楚，是不是只有我本机可以这样的操作；我们用的方案不就是修改数据库白名单，对吧。”
- The original install symptom was an ordinary ADB install rejected with `INSTALL_FAILED_VERIFICATION_FAILURE` / TCL launcher signature verification (`app.orchard.tv metaData is null`). The owner described the broader device issue as “好多 TCL 设备都说无法安装第三方桌面、跳回什么的”，and asked whether the whitelist method was unique to this unit. On this firmware, the reversible one-package launcher exception plus the TV's MultiScreen install path resolved the install block. This only establishes the procedure on this exact device/build; other TCL firmware was not tested.
- The 1.69 adaptation run was requested to validate Home, standby wake, reboot behavior, and each listed source, and to identify whether a device profile correction was needed.

## Before and after self-test

### Before: Aerial 1.46

The earlier 1.46 self-test ran with `STANDBY=1 REBOOT=1 INPUTS=1`. HomeGuard, Home from Aerial, Home from another app, and reboot passed. Standby failed once: after the TV slept for 70 seconds and woke, `com.tcl.tv` stayed foreground for 60 seconds. The `INPUTS=1` run did not actually test inputs: the source-list call returned configuration text, no input was opened, and the script's `inputs PASS 0 listed` was a false positive. A same-version repeat, with no settings changed, passed standby (Aerial returned 0.6 seconds after wake); source listing was still unavailable. Full historical outputs: [initial 1.46 run](https://github.com/littleCareless/iffalcon-t966d5-tv-notes/blob/main/diagnostics/2026-10-29-selftest.sh.md) and [repeat 1.46 run](https://github.com/littleCareless/iffalcon-t966d5-tv-notes/blob/main/diagnostics/2026-10-29-selftest-v1.46-rerun.md).

### After: Aerial 1.69

The complete current `selftest.sh` output follows the `report.sh` material below. HomeGuard, Home from Aerial, Home from another app, standby wake, reboot, and all seven listed inputs passed. Standby returned to Aerial 0.7 seconds after wake; the first post-reboot sample at 2 seconds was Aerial. The owner confirmed the visible input mapping, including the connected device on HDMI 2.

## Switches and device profile

- No Aerial behavior switch was changed during the 1.69 run. `guard_off_in_standby=false` and `keep_adb=false` remained at their existing values. The prior 1.46 standby repeat also passed without changing settings; therefore no switch was trialed as a fix.
- Device profile: Aerial diagnostics reported `None`. No profile override was applied. The tested source labels and visible mappings matched, so the final profile JSON is **none / default**; there is no correction JSON to submit.
- No brightness test was performed.

## `report.sh` full output

### adb report

```
ro.product.manufacturer = IFFALCON
ro.product.brand = TCL
ro.product.model = Smart TV Pro
ro.product.device = T966D5
ro.product.name = T966D5_4K_CN
ro.build.version.release = 14
ro.build.version.sdk = 34
ro.build.version.security_patch = 2026-03-05
ro.build.display.id = bu30a6_aosp-user 14 UTT2.250416.001 AU01 release-keys
ro.build.version.incremental = AU01
ro.build.fingerprint = TCL/T966D5_4K_CN/T966D5:14/UTT2.250416.001/AU01:user/release-keys
ro.board.platform = t6x
ro.hardware = amlogic
ro.product.cpu.abi = armeabi-v7a
ro.build.characteristics = tv,nosdcard
ro.sf.lcd_density = 320
wm size: Override size: 1920x1080  density: Physical density: 320
```

**Aerial package**
```
User 0: ceDataInode=8565 installed=true hidden=false suspended=false distractionFlags=0 stopped=false notLaunched=false enabled=0 instant=false virtual=false
installerPackageName=com.tcl.MultiScreenInteraction_TV
lastUpdateTime=2026-10-29 18:38:01
versionCode=85 minSdk=21 targetSdk=34
versionName=1.69
appops:
  Uid mode: COARSE_LOCATION: ignore
  FINE_LOCATION: ignore
  AUTO_START: allow
  ASSOC_START: allow
  SYSTEM_ALERT_WINDOW: default; rejectTime=+5d9h13m9s873ms ago
  REQUEST_DELETE_PACKAGES: allow; time=+5d9h38m56s327ms ago
  BIND_ACCESSIBILITY_SERVICE: allow; time=+3m54s865ms ago
  ACCESS_ACCESSIBILITY: allow; time=+51s58ms ago
  ACCESS_RESTRICTED_SETTINGS: allow; time=+3m24s393ms ago
  AUTO_START: allow; time=+4d23h58m51s767ms ago; rejectTime=+7d1h20m56s504ms ago
  ASSOC_START: allow
```

**Home**
```
resolves to: app.orchard.tv/.MainActivity
  2 activities found:
    Activity #0:
      priority=0 preferredOrder=0 match=0x108000 specificIndex=-1 isDefault=true
      com.tcl.cyberui/.MainActivity
    Activity #1:
      priority=0 preferredOrder=0 match=0x108000 specificIndex=-1 isDefault=true
      app.orchard.tv/.MainActivity
role holder: app.orchard.tv
foreground: topResumedActivity=ActivityRecord{45e9ae6 u0 app.orchard.tv/.MainActivity t3}
```

**Settings**
```
secure enabled_accessibility_services = app.orchard.tv/.guard.HomeGuardService
secure accessibility_enabled = 1
secure enabled_notification_listeners = app.orchard.tv/app.orchard.tv.guard.RevivalListener
secure screensaver_enabled = 1
secure screensaver_components = com.tcl.appreciate.art/.service.screensaver.ScreenSaverBootService
secure screensaver_default_component = com.tcl.appreciate.art/.service.screensaver.ScreenSaverBootService
secure install_non_market_apps = 1
global adb_enabled = 1
global picture_backlight = null
system screen_brightness = 102
system screen_brightness_mode = 0
system sound_effects_enabled = 0
system boot_app_mode = boot_launcher
system boot_app_componentname = app.orchard.tv/.MainActivity
```

**Bound services**
```
accessibility (bound):
Bound services:{Service[label=Aerial 桌面守护, feedbackType[FEEDBACK_GENERIC], capabilities=8, eventTypes=TYPE_WINDOW_STATE_CHANGED, notificationTimeout=0, requestA11yBtn=false]}
Enabled services:{{app.orchard.tv/app.orchard.tv.guard.HomeGuardService}}
notification listener: 4 mentions
```

<details><summary>TV inputs</summary>

```
TvInputHardwareInfo {id=1, type=2, audio_type=-2147467264, audio_addr=100, cable_connection_status=0}
TvInputHardwareInfo {id=15, type=9, audio_type=-2147483616, audio_addr=105, hdmi_port=1, cable_connection_status=0}
TvInputHardwareInfo {id=16, type=9, audio_type=-2147483616, audio_addr=106, hdmi_port=2, cable_connection_status=0}
TvInputHardwareInfo {id=17, type=9, audio_type=-2147483616, audio_addr=107, hdmi_port=3, cable_connection_status=0}
TvInputHardwareInfo {id=18, type=9, audio_type=-2147483616, audio_addr=108, hdmi_port=4, cable_connection_status=0}
TvInputHardwareInfo {id=2, type=2, audio_type=-2147467264, audio_addr=116, cable_connection_status=0}
TvInputHardwareInfo {id=3, type=3, audio_type=-2147450880, audio_addr=101, cable_connection_status=2}
```

</details>

<details><summary>logcat (Aerial)</summary>

```
10-29 18:44:34.543 I/ActivityManager(  842): Broadcasting: Intent { act=app.orchard.tv.CONFIG flg=0x400000 cmp=app.orchard.tv/.guard.ConfigReceiver (has extras) }
10-29 18:44:34.544 I/ActivityManager(  842): Enqueued broadcast Intent { act=app.orchard.tv.CONFIG flg=0x400000 cmp=app.orchard.tv/.guard.ConfigReceiver (has extras) }: 0
10-29 18:44:34.612 I/AerialDiag( 1303): onPause
10-29 18:44:34.690 I/AerialDiag( 1303): window focus false
10-29 18:44:34.824 I/AerialDiag( 1303): onStop
10-29 18:44:43.114 I/AerialDiag( 1303): onStart
10-29 18:44:43.120 I/ActivityTaskManager(  842): START u0 {flg=0x10000000 cmp=app.orchard.tv/.MainActivity} with LAUNCH_SINGLE_TASK from uid 2000 (BAL_ALLOW_PERMISSION) result code=2
10-29 18:44:43.146 I/AerialDiag( 1303): onNewIntent null
10-29 18:44:43.147 I/AerialDiag( 1303): onResume; screensaver after 300 s
10-29 18:44:43.246 I/ActivityTaskManager(  842): TFWD:notifyWindowsDrawn ActivityRecord{45e9ae6 u0 app.orchard.tv/.MainActivity t3}
10-29 18:44:43.255 I/AerialDiag( 1303): 21 apps in 124 ms (wait 5, queries 25, tiles 6, main 88)
10-29 18:44:43.270 I/AerialDiag( 1303): tile faces in 14 ms
10-29 18:44:43.271 W/ActivityTaskManager(  842): ActivityRecord idle....app.orchard.tv
10-29 18:44:43.277 I/AerialDiag( 1303): window focus true
10-29 18:44:45.567 I/ActivityManager(  842): Broadcasting: Intent { act=app.orchard.tv.CONFIG flg=0x400000 cmp=app.orchard.tv/.guard.ConfigReceiver (has extras) }
10-29 18:44:45.568 I/ActivityManager(  842): Enqueued broadcast Intent { act=app.orchard.tv.CONFIG flg=0x400000 cmp=app.orchard.tv/.guard.ConfigReceiver (has extras) }: 0
10-29 18:44:45.629 I/AerialDiag( 1303): onPause
10-29 18:44:45.697 I/AerialDiag( 1303): window focus false
10-29 18:44:45.871 I/AerialDiag( 1303): onStop
10-29 18:44:53.970 I/AerialDiag( 1303): onStart
10-29 18:44:53.975 I/ActivityTaskManager(  842): START u0 {flg=0x10000000 cmp=app.orchard.tv/.MainActivity} with LAUNCH_SINGLE_TASK from uid 2000 (BAL_ALLOW_PERMISSION) result code=2
10-29 18:44:53.995 I/AerialDiag( 1303): onNewIntent null
10-29 18:44:53.996 I/AerialDiag( 1303): onResume; screensaver after 300 s
10-29 18:44:54.071 I/ActivityTaskManager(  842): TFWD:notifyWindowsDrawn ActivityRecord{45e9ae6 u0 app.orchard.tv/.MainActivity t3}
10-29 18:44:54.079 I/AerialDiag( 1303): 21 apps in 90 ms (wait 5, queries 17, tiles 8, main 60)
10-29 18:44:54.097 I/AerialDiag( 1303): window focus true
10-29 18:44:54.137 I/AerialDiag( 1303): tile faces in 30 ms
10-29 18:44:54.163 W/ActivityTaskManager(  842): ActivityRecord idle....app.orchard.tv
10-29 18:44:56.260 I/ActivityManager(  842): Broadcasting: Intent { act=app.orchard.tv.CONFIG flg=0x400000 cmp=app.orchard.tv/.guard.ConfigReceiver (has extras) }
10-29 18:44:56.261 I/ActivityManager(  842): Enqueued broadcast Intent { act=app.orchard.tv.CONFIG flg=0x400000 cmp=app.orchard.tv/.guard.ConfigReceiver (has extras) }: 0
10-29 18:44:56.324 I/AerialDiag( 1303): onPause
10-29 18:44:56.389 I/AerialDiag( 1303): window focus false
10-29 18:44:56.538 I/AerialDiag( 1303): onStop
10-29 18:45:05.095 I/AerialDiag( 1303): onStart
10-29 18:45:05.100 I/ActivityTaskManager(  842): START u0 {flg=0x10000000 cmp=app.orchard.tv/.MainActivity} with LAUNCH_SINGLE_TASK from uid 2000 (BAL_ALLOW_PERMISSION) result code=2
10-29 18:45:05.118 I/AerialDiag( 1303): onNewIntent null
10-29 18:45:05.119 I/AerialDiag( 1303): onResume; screensaver after 300 s
10-29 18:45:05.200 I/ActivityTaskManager(  842): TFWD:notifyWindowsDrawn ActivityRecord{45e9ae6 u0 app.orchard.tv/.MainActivity t3}
10-29 18:45:05.208 I/AerialDiag( 1303): 21 apps in 98 ms (wait 3, queries 26, tiles 5, main 64)
10-29 18:45:05.233 I/AerialDiag( 1303): tile faces in 22 ms
10-29 18:45:05.239 W/ActivityTaskManager(  842): ActivityRecord idle....app.orchard.tv
10-29 18:45:05.243 I/AerialDiag( 1303): window focus true
10-29 18:45:07.411 I/ActivityManager(  842): Broadcasting: Intent { act=app.orchard.tv.CONFIG flg=0x400000 cmp=app.orchard.tv/.guard.ConfigReceiver (has extras) }
10-29 18:45:07.412 I/ActivityManager(  842): Enqueued broadcast Intent { act=app.orchard.tv.CONFIG flg=0x400000 cmp=app.orchard.tv/.guard.ConfigReceiver (has extras) }: 0
10-29 18:45:07.474 I/AerialDiag( 1303): onPause
10-29 18:45:07.551 I/AerialDiag( 1303): window focus false
10-29 18:45:07.689 I/AerialDiag( 1303): onStop
10-29 18:45:15.744 I/AerialDiag( 1303): onStart
10-29 18:45:15.748 I/ActivityTaskManager(  842): START u0 {flg=0x10000000 cmp=app.orchard.tv/.MainActivity} with LAUNCH_SINGLE_TASK from uid 2000 (BAL_ALLOW_PERMISSION) result code=2
10-29 18:45:15.768 I/AerialDiag( 1303): onNewIntent null
10-29 18:45:15.769 I/AerialDiag( 1303): onResume; screensaver after 300 s
10-29 18:45:15.847 I/ActivityTaskManager(  842): TFWD:notifyWindowsDrawn ActivityRecord{45e9ae6 u0 app.orchard.tv/.MainActivity t3}
10-29 18:45:15.864 I/AerialDiag( 1303): 21 apps in 103 ms (wait 1, queries 38, tiles 12, main 52)
10-29 18:45:15.871 I/AerialDiag( 1303): tile faces in 6 ms
10-29 18:45:15.872 W/ActivityTaskManager(  842): ActivityRecord idle....app.orchard.tv
10-29 18:45:15.894 I/AerialDiag( 1303): window focus true
10-29 18:45:18.273 I/ActivityManager(  842): Broadcasting: Intent { act=app.orchard.tv.CONFIG flg=0x400000 cmp=app.orchard.tv/.guard.ConfigReceiver (has extras) }
10-29 18:45:18.275 I/ActivityManager(  842): Enqueued broadcast Intent { act=app.orchard.tv.CONFIG flg=0x400000 cmp=app.orchard.tv/.guard.ConfigReceiver (has extras) }: 0
10-29 18:45:18.334 I/AerialDiag( 1303): onPause
10-29 18:45:18.422 I/AerialDiag( 1303): window focus false
10-29 18:45:18.555 I/AerialDiag( 1303): onStop
10-29 18:45:26.949 I/AerialDiag( 1303): onStart
10-29 18:45:26.953 I/ActivityTaskManager(  842): START u0 {flg=0x10000000 cmp=app.orchard.tv/.MainActivity} with LAUNCH_SINGLE_TASK from uid 2000 (BAL_ALLOW_PERMISSION) result code=2
10-29 18:45:26.990 I/AerialDiag( 1303): onNewIntent null
10-29 18:45:26.991 I/AerialDiag( 1303): onResume; screensaver after 300 s
10-29 18:45:27.092 I/ActivityTaskManager(  842): TFWD:notifyWindowsDrawn ActivityRecord{45e9ae6 u0 app.orchard.tv/.MainActivity t3}
10-29 18:45:27.138 I/AerialDiag( 1303): 21 apps in 169 ms (wait 9, queries 54, tiles 36, main 70)
10-29 18:45:27.143 I/AerialDiag( 1303): window focus true
10-29 18:45:27.156 I/AerialDiag( 1303): tile faces in 15 ms
10-29 18:45:27.196 W/ActivityTaskManager(  842): ActivityRecord idle....app.orchard.tv
10-29 18:45:29.343 I/ActivityManager(  842): Broadcasting: Intent { act=app.orchard.tv.CONFIG flg=0x400000 cmp=app.orchard.tv/.guard.ConfigReceiver (has extras) }
10-29 18:45:29.344 I/ActivityManager(  842): Enqueued broadcast Intent { act=app.orchard.tv.CONFIG flg=0x400000 cmp=app.orchard.tv/.guard.ConfigReceiver (has extras) }: 0
10-29 18:45:29.431 I/AerialDiag( 1303): onPause
10-29 18:45:29.485 I/AerialDiag( 1303): window focus false
10-29 18:45:30.365 I/AerialDiag( 1303): onStop
10-29 18:45:38.663 I/AerialDiag( 1303): onStart
10-29 18:45:38.673 I/ActivityTaskManager(  842): START u0 {flg=0x10000000 cmp=app.orchard.tv/.MainActivity} with LAUNCH_SINGLE_TASK from uid 2000 (BAL_ALLOW_PERMISSION) result code=2
10-29 18:45:38.696 I/AerialDiag( 1303): onNewIntent null
10-29 18:45:38.697 I/AerialDiag( 1303): onResume; screensaver after 300 s
10-29 18:45:38.792 I/ActivityTaskManager(  842): TFWD:notifyWindowsDrawn ActivityRecord{45e9ae6 u0 app.orchard.tv/.MainActivity t3}
10-29 18:45:38.805 I/AerialDiag( 1303): 21 apps in 120 ms (wait 6, queries 46, tiles 17, main 51)
10-29 18:45:38.815 I/AerialDiag( 1303): tile faces in 8 ms
10-29 18:45:38.818 W/ActivityTaskManager(  842): ActivityRecord idle....app.orchard.tv
10-29 18:45:38.827 I/AerialDiag( 1303): window focus true
10-29 18:45:41.230 I/AerialDiag( 1303): onPause
10-29 18:45:41.232 I/AerialDiag( 1303): onNewIntent null
10-29 18:45:41.233 I/AerialDiag( 1303): onResume; screensaver after 300 s
10-29 18:45:41.234 I/ActivityTaskManager(  842): START u0 {flg=0x10000000 cmp=app.orchard.tv/.MainActivity} with LAUNCH_SINGLE_TASK from uid 2000 (BAL_ALLOW_PERMISSION) result code=3
10-29 18:45:41.272 W/ActivityTaskManager(  842): ActivityRecord idle....app.orchard.tv
```

</details>

### Aerial diagnostics

```
Aerial      1.69 (85) standard, package app.orchard.tv, installer com.tcl.MultiScreenInteraction_TV
Device      IFFALCON / IFFALCON / Smart TV Pro (device T966D5, product T966D5_4K_CN, hardware amlogic, board bu30a6)
Android     14 (SDK 34), patch 2026-03-05
Build       bu30a6_aosp-user 14 UTT2.250416.001 AU01 release-keys
Fingerprint TCL/T966D5_4K_CN/T966D5:14/UTT2.250416.001/AU01:user/release-keys
  ro.board.platform = t6x
  ro.product.cpu.abi = armeabi-v7a
  ro.build.characteristics = tv,nosdcard
Screen      1920x1080 320dpi 60Hz; modes 3840x2160@60, 3840x2160@60, 3840x2160@50
Memory      1956 MB, low-RAM device=false
Network     Ethernet
```

**Home**
```
Resolves to app.orchard.tv/app.orchard.tv.MainActivity  (Default)
  candidate com.tcl.cyberui/com.tcl.cyberui.MainActivity priority=0
  candidate app.orchard.tv/app.orchard.tv.MainActivity priority=0
  guard keeps away com.tcl.cyberui: com.tcl.cyberui.MainActivity
```

**Takeover**
```
Home Guard  enabled=true running=true
  accessibility services: app.orchard.tv/.guard.HomeGuardService
Revival     notification listener allowed=true, revivals in 10 min=fewer than 3
Grants      WRITE_SECURE_SETTINGS=true overlay=false WRITE_SETTINGS=false install=true location=false usage=false package_source=0
ADB         adb_enabled=1 keep_adb=false guard_off_in_standby=false
Screensaver enabled=1 components=com.tcl.appreciate.art/.service.screensaver.ScreenSaverBootService Aerial's=Aerial
Sounds      sound_effects_enabled=0
Effects     auto, lite=false; low-end=false (low-RAM flag false, 1956 MB, 5 cores, memory class 256 MB)
Compiled    with profile=false, profile waiting=true, code=2; odex 48 KB
Frames      last 34 frames: median 44.8 ms, p90 135.8 ms, p99 1132.0 ms, slowest 1233.9 ms; GPU median 5.5 ms, p90 14.0 ms; over 16.7 ms: 34 of 34 since 5 s after start
Settings    focus=high_contrast one_row=true columns=5 peek=true names=false boot_source=false boot_app=null
            wallpaper=daily:latest always_moves=false quality=auto weather=true saver_clock=true
```

**Brightness**
```
Aerial can set it: false
  global picture_backlight=null  system screen_brightness=102 mode=0
```

**Inputs**
```
com.tcl.tvinput/.TvPassThroughService/HW3 type=composite "AV" state=2 passthrough
com.tcl.tvinput/.TvPassThroughService/HW17 type=hdmi "HDMI 3" state=1 passthrough
com.tcl.tvinput/.TvPassThroughService/HW18 type=hdmi "HDMI 4" state=1 passthrough
com.tcl.tvinput/.TunerInputService/HW2 type=tuner "TV" state=0
com.tcl.tvinput/.TvPassThroughService/HW15 type=hdmi "HDMI 1" state=1 passthrough
com.tcl.tvinput/.TvPassThroughService/HW16 type=hdmi "HDMI 2" state=1 passthrough
com.tcl.tvinput/.TvPassThroughService/HDMI200004 type=hdmi "[本机 HDMI-CEC 自定义名称已脱敏]" state=0 parent=com.tcl.tvinput/.TvPassThroughService/HW16 passthrough
  shown: HDMI 1 [Hdmi] connected=false -> com.tcl.tv/.TVActivity id=com.tcl.tvinput/.TvPassThroughService/HW15
  shown: HDMI 2 [Hdmi] connected=true -> com.tcl.tv/.TVActivity id=com.tcl.tvinput/.TvPassThroughService/HW16
  shown: HDMI 3 [Hdmi] connected=false -> com.tcl.tv/.TVActivity id=com.tcl.tvinput/.TvPassThroughService/HW17
  shown: HDMI 4 [Hdmi] connected=false -> com.tcl.tv/.TVActivity id=com.tcl.tvinput/.TvPassThroughService/HW18
  shown: TV [Tuner] connected=false -> com.tcl.tv/.TVActivity id=com.tcl.tvinput/.TunerInputService/HW2
  shown: AV [Av] connected=false -> com.tcl.tv/.TVActivity id=com.tcl.tvinput/.TvPassThroughService/HW3
  shown: USB [Usb] connected=false -> com.tcl.ui_mediaCenter/.main.MainActivity id=usb
```

**Device profile** (None)
```json
{"models":["Smart TV Pro"]}
```

**Packages**
```
com.tcl.settings 3.39.03_0cdde2a_260915_master
com.tcl.tv 3.19.00_00ec691_260605
com.tcl.MultiScreenInteraction_TV 5.30_260904
com.tcl.appmarket2 7.3.1.8_U
```

<details><summary>Log</summary>

```
10-29 18:42:29.071 +18857 onCreate before the user is unlocked; showing the kept backdrop
10-29 18:42:29.962 +19741 window focus true
10-29 18:42:31.596 +21374 revival: starting checks: service created
10-29 18:42:31.604 +21383 revival: notification listener connected
10-29 18:42:35.355 +22833 revival: starting checks: service created
10-29 18:42:35.517 +22995 onCreate android.intent.action.MAIN restored=false; IFFALCON Smart TV Pro (T966D5, amlogic, bu30a6), Android 14 (SDK 34), TCL/T966D5_4K_CN/T966D5:14/UTT2.250416.001/AU01:user/release-keys, Aerial 1.69 (85)
10-29 18:42:35.876 +23354 display 1920x1080 320dpi, canvas density 2.0, uhd 1.0 (auto: no 4K UI plane (mode 3840 for a 1920 UI)); mode 1 3840x2160@60.000004 (seamless: 50.0, 59.94006) of 1:3840x2160@60.000004, 2:3840x2160@59.94006, 3:3840x2160@50.0; hwui , soft_layer=false, saver_fade_offscreen=false
10-29 18:42:36.164 +23642 onStart
10-29 18:42:36.378 +23856 onResume; screensaver after 300 s
10-29 18:42:36.381 +23859 revival: notification listener connected
10-29 18:42:36.446 +23924 LOCKED_BOOT_COMPLETED handled in 65 ms
10-29 18:42:36.775 +24253 draw 1: 1920x1080, hw=true
10-29 18:42:37.338 +24816 draw 2: 1920x1080, hw=true
10-29 18:42:37.345 +24823 21 apps in 996 ms (wait 13, queries 74, tiles 327, main 582)
10-29 18:42:37.350 +24828 Home loaded: 21 tiles, 7 inputs, 1001 ms
10-29 18:42:37.656 +25134 draw 3: 1920x1080, hw=true
10-29 18:42:38.140 +25620 8 more tiles in 790 ms
10-29 18:42:38.248 +25726 2s: frame after 101 ms, draws 4, focus true, shown true, state RESUMED, apps 21 loaded true, screensaver false, overlay None
10-29 18:42:38.463 +25941 tile 云视听极光 drawn before its face, 338x190
10-29 18:42:38.748 +26226 tile faces in 608 ms
10-29 18:42:40.356 +27834 revival: guard bound
10-29 18:42:43.890 +31368 8s: frame after 14 ms, draws 20, focus true, shown true, state RESUMED, apps 21 loaded true, screensaver false, overlay None
10-29 18:42:49.890 +37368 14s: frame after 14 ms, draws 20, focus true, shown true, state RESUMED, apps 21 loaded true, screensaver false, overlay None
10-29 18:42:55.890 +43368 20s: frame after 8 ms, draws 20, focus true, shown true, state RESUMED, apps 21 loaded true, screensaver false, overlay None
10-29 18:43:01.533 +49011 21 apps in 73 ms (wait 0, queries 14, tiles 59, main 0)
10-29 18:43:01.584 +49062 tile faces in 49 ms
10-29 18:43:01.890 +49368 26s: frame after 12 ms, draws 22, focus true, shown true, state RESUMED, apps 21 loaded true, screensaver false, overlay None
10-29 18:43:05.221 +52699 BOOT_COMPLETED handled in 21 ms
10-29 18:43:07.890 +55368 32s: frame after 14 ms, draws 23, focus true, shown true, state RESUMED, apps 21 loaded true, screensaver false, overlay None
10-29 18:43:13.890 +61368 38s: frame after 13 ms, draws 23, focus true, shown true, state RESUMED, apps 21 loaded true, screensaver false, overlay None
10-29 18:43:15.740 +63218 21 apps in 51 ms (wait 1, queries 25, tiles 24, main 1)
10-29 18:43:15.760 +63238 tile faces in 1 ms
10-29 18:43:19.890 +67368 44s: frame after 12 ms, draws 23, focus true, shown true, state RESUMED, apps 21 loaded true, screensaver false, overlay None
10-29 18:43:25.890 +73368 50s: frame after 11 ms, draws 23, focus true, shown true, state RESUMED, apps 21 loaded true, screensaver false, overlay None
10-29 18:43:31.890 +79368 56s: frame after 13 ms, draws 23, focus true, shown true, state RESUMED, apps 21 loaded true, screensaver false, overlay None
10-29 18:43:37.890 +85368 62s: frame after 7 ms, draws 23, focus true, shown true, state RESUMED, apps 21 loaded true, screensaver false, overlay None
10-29 18:43:43.890 +91368 68s: frame after 7 ms, draws 23, focus true, shown true, state RESUMED, apps 21 loaded true, screensaver false, overlay None
10-29 18:43:49.890 +97368 74s: frame after 9 ms, draws 23, focus true, shown true, state RESUMED, apps 21 loaded true, screensaver false, overlay None
10-29 18:43:55.890 +103368 80s: frame after 7 ms, draws 23, focus true, shown true, state RESUMED, apps 21 loaded true, screensaver false, overlay None
10-29 18:44:01.890 +109368 86s: frame after 12 ms, draws 25, focus true, shown true, state RESUMED, apps 21 loaded true, screensaver false, overlay None
10-29 18:44:07.890 +115368 92s: frame after 7 ms, draws 25, focus true, shown true, state RESUMED, apps 21 loaded true, screensaver false, overlay None
10-29 18:44:13.890 +121368 98s: frame after 8 ms, draws 25, focus true, shown true, state RESUMED, apps 21 loaded true, screensaver false, overlay None
10-29 18:44:19.890 +127368 104s: frame after 7 ms, draws 25, focus true, shown true, state RESUMED, apps 21 loaded true, screensaver false, overlay None
10-29 18:44:23.519 +130997 onPause
10-29 18:44:23.639 +131117 window focus false
10-29 18:44:24.360 +131838 onStop
10-29 18:44:25.890 +133368 110s: frame after 12 ms, draws 28, focus false, shown false, state CREATED, apps 21 loaded true, screensaver false, overlay None
10-29 18:44:31.890 +139368 116s: frame after 8 ms, draws 28, focus false, shown false, state CREATED, apps 21 loaded true, screensaver false, overlay None
10-29 18:44:32.044 +139522 onStart
10-29 18:44:32.071 +139549 onNewIntent null
10-29 18:44:32.072 +139550 onResume; screensaver after 300 s
10-29 18:44:32.187 +139666 21 apps in 124 ms (wait 1, queries 37, tiles 27, main 59)
10-29 18:44:32.195 +139673 tile faces in 5 ms
10-29 18:44:32.211 +139690 window focus true
10-29 18:44:34.612 +142090 onPause
10-29 18:44:34.690 +142168 window focus false
10-29 18:44:34.824 +142302 onStop
10-29 18:44:43.114 +150592 onStart
10-29 18:44:43.146 +150624 onNewIntent null
10-29 18:44:43.147 +150625 onResume; screensaver after 300 s
10-29 18:44:43.255 +150733 21 apps in 124 ms (wait 5, queries 25, tiles 6, main 88)
10-29 18:44:43.270 +150748 tile faces in 14 ms
10-29 18:44:43.277 +150755 window focus true
10-29 18:44:45.629 +153107 onPause
10-29 18:44:45.697 +153175 window focus false
10-29 18:44:45.871 +153349 onStop
10-29 18:44:53.970 +161448 onStart
10-29 18:44:53.995 +161473 onNewIntent null
10-29 18:44:53.996 +161474 onResume; screensaver after 300 s
10-29 18:44:54.079 +161557 21 apps in 90 ms (wait 5, queries 17, tiles 8, main 60)
10-29 18:44:54.097 +161575 window focus true
10-29 18:44:54.137 +161615 tile faces in 30 ms
10-29 18:44:56.324 +163803 onPause
10-29 18:44:56.389 +163868 window focus false
10-29 18:44:56.538 +164016 onStop
10-29 18:45:05.095 +172573 onStart
10-29 18:45:05.118 +172596 onNewIntent null
10-29 18:45:05.119 +172597 onResume; screensaver after 300 s
10-29 18:45:05.208 +172687 21 apps in 98 ms (wait 3, queries 26, tiles 5, main 64)
10-29 18:45:05.233 +172711 tile faces in 22 ms
10-29 18:45:05.243 +172721 window focus true
10-29 18:45:07.474 +174952 onPause
10-29 18:45:07.551 +175029 window focus false
10-29 18:45:07.690 +175169 onStop
10-29 18:45:15.744 +183222 onStart
10-29 18:45:15.768 +183246 onNewIntent null
10-29 18:45:15.769 +183247 onResume; screensaver after 300 s
10-29 18:45:15.864 +183342 21 apps in 103 ms (wait 1, queries 38, tiles 12, main 52)
10-29 18:45:15.871 +183349 tile faces in 6 ms
10-29 18:45:15.894 +183372 window focus true
10-29 18:45:18.334 +185812 onPause
10-29 18:45:18.422 +185900 window focus false
10-29 18:45:18.555 +186034 onStop
10-29 18:45:26.949 +194429 onStart
10-29 18:45:26.990 +194468 onNewIntent null
10-29 18:45:26.991 +194469 onResume; screensaver after 300 s
10-29 18:45:27.138 +194617 21 apps in 169 ms (wait 9, queries 54, tiles 36, main 70)
10-29 18:45:27.143 +194621 window focus true
10-29 18:45:27.156 +194634 tile faces in 15 ms
10-29 18:45:29.431 +196909 onPause
10-29 18:45:29.485 +196963 window focus false
10-29 18:45:30.365 +197843 onStop
10-29 18:45:38.663 +206141 onStart
10-29 18:45:38.696 +206174 onNewIntent null
10-29 18:45:38.697 +206175 onResume; screensaver after 300 s
10-29 18:45:38.805 +206283 21 apps in 120 ms (wait 6, queries 46, tiles 17, main 51)
10-29 18:45:38.815 +206293 tile faces in 8 ms
10-29 18:45:38.827 +206305 window focus true
10-29 18:45:41.230 +208708 onPause
10-29 18:45:41.232 +208710 onNewIntent null
10-29 18:45:41.233 +208711 onResume; screensaver after 300 s
--- logcat
```

</details>


## `selftest.sh` full output

### Aerial self-test

Smart TV Pro, Android 14, Aerial 1.69, 2026-10-29

```
guard              PASS Aerial is the default home (app.orchard.tv/.MainActivity)
home_on_aerial     PASS Aerial in front
home_from_app      PASS from com.kookong.tvplus, Aerial in front after 0.9 s
(standby: Asleep; waiting 70 s)
standby            PASS asleep=Asleep, Aerial in front 0.7 s after wake
(restarting; waiting up to 4 minutes for ADB)
reboot             PASS after boot: 2s:app.orchard.tv
  input 1: HDMI 1 (com.tcl.tvinput/.TvPassThroughService/HW15) -> HDMI 1 -> com.tcl.tv/.TVActivity; in front com.tcl.tv; screenshot aerial-selftest-Smart_TV_Pro/input-1.png
  input 2: HDMI 2 (com.tcl.tvinput/.TvPassThroughService/HW16) -> HDMI 2 -> com.tcl.tv/.TVActivity; in front com.tcl.tv; screenshot aerial-selftest-Smart_TV_Pro/input-2.png
  input 3: HDMI 3 (com.tcl.tvinput/.TvPassThroughService/HW17) -> HDMI 3 -> com.tcl.tv/.TVActivity; in front com.tcl.tv; screenshot aerial-selftest-Smart_TV_Pro/input-3.png
  input 4: HDMI 4 (com.tcl.tvinput/.TvPassThroughService/HW18) -> HDMI 4 -> com.tcl.tv/.TVActivity; in front com.tcl.tv; screenshot aerial-selftest-Smart_TV_Pro/input-4.png
  input 5: TV (com.tcl.tvinput/.TunerInputService/HW2) -> TV -> com.tcl.tv/.TVActivity; in front com.tcl.tv; screenshot aerial-selftest-Smart_TV_Pro/input-5.png
  input 6: AV (com.tcl.tvinput/.TvPassThroughService/HW3) -> AV -> com.tcl.tv/.TVActivity; in front com.tcl.tv; screenshot aerial-selftest-Smart_TV_Pro/input-6.png
  input 7: USB (usb) -> USB -> com.tcl.ui_mediaCenter/.main.MainActivity; in front com.tcl.ui_mediaCenter; screenshot aerial-selftest-Smart_TV_Pro/input-7.png
inputs             PASS 7 listed; each opened, see the screenshots and tell which port each showed
```

**Inputs as Aerial lists them**
```json
[{"id":"com.tcl.tvinput\/.TvPassThroughService\/HW15","label":"HDMI 1","kind":"Hdmi","shown":true,"hw":15,"firmwareLabel":"HDMI 1"},{"id":"com.tcl.tvinput\/.TvPassThroughService\/HW16","label":"HDMI 2","kind":"Hdmi","shown":true,"hw":16,"firmwareLabel":"HDMI 2"},{"id":"com.tcl.tvinput\/.TvPassThroughService\/HW17","label":"HDMI 3","kind":"Hdmi","shown":true,"hw":17,"firmwareLabel":"HDMI 3"},{"id":"com.tcl.tvinput\/.TvPassThroughService\/HW18","label":"HDMI 4","kind":"Hdmi","shown":true,"hw":18,"firmwareLabel":"HDMI 4"},{"id":"com.tcl.tvinput\/.TunerInputService\/HW2","label":"TV","kind":"Tuner","shown":true,"hw":2,"firmwareLabel":"TV"},{"id":"com.tcl.tvinput\/.TvPassThroughService\/HW3","label":"AV","kind":"Av","shown":true,"hw":3,"firmwareLabel":"AV"},{"id":"usb","label":"USB","kind":"Usb","shown":true}]
```

**Self-test result**
```json
{"model":"Smart TV Pro","aerial":"1.69","checks":{"guard":{"result":"pass","detail":"Aerial is the default home (app.orchard.tv/.MainActivity)"},"home_on_aerial":{"result":"pass","detail":"Aerial in front"},"home_from_app":{"result":"pass","detail":"from com.kookong.tvplus, Aerial in front after 0.9 s"},"standby":{"result":"pass","detail":"asleep=Asleep, Aerial in front 0.7 s after wake"},"reboot":{"result":"pass","detail":"after boot: 2s:app.orchard.tv"},"inputs":{"result":"pass","detail":"7 listed; each opened, see the screenshots and tell which port each showed"}}}
```


## Agent diagnostic summary

- Device: IFFALCON / TCL Smart TV Pro, device `T966D5`, product `T966D5_4K_CN`; Android 14 / SDK 34, build `UTT2.250416.001` / `AU01`.
- Installed Aerial: official standard 1.69, versionCode 85, package `app.orchard.tv`. The official APK hash and signer matched the staged release and existing signer.
- Update procedure: only Aerial was updated via the TV's MultiScreen install channel. The temporary `app.orchard.tv` launcher-strategy exception was restored. After the second update reboot, the InstallConfig database and cache exactly matched the pre-update snapshot. Verification found package inventory and disabled-package state unchanged; no original apps were uninstalled or deleted.
- HOME and HomeGuard: all passed. Aerial is the default HOME; Home from Aerial and from another app returned to Aerial.
- Boot: selftest first sampled Aerial 2 seconds after reboot. The owner separately confirmed the TV visibly entered Aerial without pressing Home.
- Standby: after `Asleep` and the 70-second wait, Aerial returned 0.7 seconds after wake. This run passed with `guard_off_in_standby=false`; no special standby setting was enabled. A 1.46 run earlier failed once and passed once on repeat, so only this 1.69 run is recorded as a pass; long-term repeatability is not established.
- Inputs: Aerial listed HDMI 1 (HW15), HDMI 2 (HW16), HDMI 3 (HW17), HDMI 4 (HW18), TV (HW2), AV (HW3), and USB. Each was opened from Aerial. HDMI 1–4, TV, and AV resolved to `com.tcl.tv/.TVActivity`; USB resolved to `com.tcl.ui_mediaCenter/.main.MainActivity`. The owner confirmed the visible source mapping was correct and HDMI 2 showed the connected device. No mapping correction was needed.
- Device profile: Aerial reports **None**; no custom `device_profile` was applied.
- Brightness was not tested.

### Result

No device-specific Aerial profile change is needed based on these tests. HOME, visible boot entry, standby return, and all seven source mappings passed on this T966D5 / AU01 / Aerial 1.69 combination. This is a single-device result, not a guarantee for other TCL/FFALCON firmware.


Earlier Aerial 1.46 output and the initial inconsistent standby result are retained in [the 1.46 diagnostic files](../diagnostics/2026-10-29-selftest-v1.46-rerun.md) and the earlier failure record.
