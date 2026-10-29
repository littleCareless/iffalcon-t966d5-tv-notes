#!/bin/sh
set -eu

ADB=${ADB:-adb}
ADB_SERVER_PORT=${ADB_SERVER_PORT:-5037}
TV_SERIAL=${TV_SERIAL:?Set TV_SERIAL to the TV current ADB serial, for example TV_ADDRESS:5555}

adb_tv() {
  "$ADB" -P "$ADB_SERVER_PORT" -s "$TV_SERIAL" "$@"
}

for pkg in \
  com.tcl.bootadservice \
  com.tcl.wholenetsearch \
  com.tcl.playskill \
  com.tcl.useragreement \
  com.tcl.appreciate.art \
  com.tcl.c2dm.client \
  com.tcl.logkit \
  com.tcl.usercenter \
  com.tcl.ttvs \
  com.tcl.guard \
  com.tcl.profilemanager \
  com.tcl.xian.StartandroidService \
  com.tcl.atomic.servicecenter \
  com.tcl.repairguide \
  com.tcl.ffeducation \
  com.tcl.hotelmenu \
  com.tcl.vod \
  com.tcl.walleve
do
  adb_tv shell pm enable --user 0 "$pkg"
done

# Enabling Walleve does not necessarily restore its AccessibilityService entry.
WALLEVE_SERVICE='com.tcl.walleve/com.tcl.walleve.platform.accessibility.AiAccessibilityService'
CURRENT_SERVICES=$(adb_tv shell settings get secure enabled_accessibility_services | tr -d '\r')
case ":$CURRENT_SERVICES:" in
  *":$WALLEVE_SERVICE:"*) ;;
  *)
    if [ -z "$CURRENT_SERVICES" ] || [ "$CURRENT_SERVICES" = "null" ]; then
      CURRENT_SERVICES="$WALLEVE_SERVICE"
    else
      CURRENT_SERVICES="$CURRENT_SERVICES:$WALLEVE_SERVICE"
    fi
    adb_tv shell settings put secure enabled_accessibility_services "$CURRENT_SERVICES"
    adb_tv shell settings put secure accessibility_enabled 1
    ;;
esac

adb_tv shell pm list packages -d --user 0
adb_tv shell settings get secure enabled_accessibility_services
