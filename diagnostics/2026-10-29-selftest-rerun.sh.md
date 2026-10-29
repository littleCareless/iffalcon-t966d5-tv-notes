# `selftest.sh` repeat run on Aerial 1.69 (redacted)

Captured 2026-10-29 with `STANDBY=1 REBOOT=1 INPUTS=1`. The owner watched the source test and confirmed the labels matched the actual inputs; HDMI 2 showed the connected device correctly. Screenshot files remain in the private test run.

~~~text
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

~~~
