# Social media research and publication kit

Prepared 2026-10-29. This is a draft for the device owner to review and post; nothing here is published to Douyin or Xiaohongshu.

## What has been getting attention

Recent Android TV modification stories tend to combine a familiar frustration with a visible result and a concrete trail others can inspect:

1. **Start with a specific pain point.** The widely shared Gathin story began with an ad before Netflix on a family Xiaomi TV. Secondary coverage reported tens of thousands of likes and millions of views on X within about two days. The reported counts differ between articles and are time-dependent, so do not quote them as a verified live count. [What’s Worth Buying report, 2026-10-25](https://post.smzdm.com/p/a4qx050l/)
2. **Show the before and after immediately.** The original story was described with a side-by-side home-screen comparison. The visual makes the change legible before the viewer knows what ADB or a launcher is. [What’s Worth Buying report, 2026-10-24](https://post.smzdm.com/p/a70plzwl/)
3. **Tell the troubleshooting story, not just the result.** A detailed Xiaomi case documents the failed ADB connection, the vendor permission limitation, the backup/restore plan, and the fact that disabling the advertisement service alone did not remove ads embedded in the launcher. The diagnostic turns make it more useful than a simple “one prompt fixed it” claim. [Hands-on Xiaomi TV write-up](https://www.getob.cc/zh-cn/posts/2026-10-19-mitv-debloat/)
4. **Make the evidence reusable.** The Aerial project itself emphasizes model-specific setup, recoverability, and a compatibility boundary: its behavior can differ by manufacturer, model, and firmware. [Aerial setup and device guidance](https://aerial.qust.me/)
5. **Invite a useful question.** A good ending asks viewers for their brand/model and what they want tested, rather than promising a universal one-click recipe.

One secondary report also quoted a Xiaohongshu TV-modding note with 481 likes and 479 saves over two days, and a separate “AI Harness reverse-engineered two TVs” note with 677 likes, 933 saves, and 147 comments. These are reported snapshots from a media roundup, not counts I independently verified inside Xiaohongshu. Treat them as examples of audience interest, not a performance promise. [What’s Worth Buying roundup](https://post.smzdm.com/p/a70pg5lo/)

## Our case, stated accurately

- Device: owner-identified as a 2027 85-inch Thunderbird He 6 Ultra; Android reports IFFALCON/TCL T966D5, Android 14, build `UTT2.250416.001 AU01`. The marketed name is owner-provided and is kept distinct from the firmware identifier.
- Goal: replace the HOME experience with Aerial while preserving the original system apps; CyberUI remains installed and enabled as fallback. A later, separate experiment disabled 18 packages without uninstalling them.
- Main obstacle: TCL's installer rejected Aerial's HOME-capable APK with a vendor verification failure.
- Working path on this unit: use the TV's MultiScreen installation route and a temporary, package-specific exception for `app.orchard.tv` in TCL's launcher install strategy. The relevant config was changed through the TCL config provider and its feature cache; this was not simply editing a database file by hand. The saved original strategy was restored after the installation/update.
- Result: official Aerial standard 1.46 was observed as the default HOME and on screen after reboot without a Home-key command. CyberUI stayed installed and enabled as fallback.
- Later optional debloat trial: 18 packages were disabled reversibly, not uninstalled. This is specific to this unit and is not the core HOME workaround. The repo records effects and rollback information.
- Known limits from the 2026-10-29 self-test: standby wake did **not** return to Aerial within 60 seconds; the Aerial signal-source enumeration script failed to retrieve a list, so no input-by-input test was completed. The script's “0 inputs PASS” is a false positive and is corrected in the diagnostics note.
- This is a single-device observation. It does not establish that other TCL televisions or firmware builds use the same config keys or installation behavior.

## Suggested title and hooks

**Primary title:** `雷鸟鹤6 Ultra 换桌面实测：第三方桌面被拦后，我这样排查`

Possible opening lines:

- `这台雷鸟电视装第三方桌面，第一次被系统安装校验拦了。`
- `折腾电视桌面最难的不是装 APK，而是找出厂商到底拦在哪一层。`
- `我没有刷机，也没删原厂桌面：最后让 Aerial 接管了 Home 键和开机入口。`

Avoid “所有 TCL 都适用”“永久去广告”“AI 一句话完全控制电视” and similar universal claims.

## Douyin short-video draft (about 35 seconds)

**0–3 s — hook, show the TV**  
On-screen: `雷鸟鹤6 Ultra 装第三方桌面，被系统拦了怎么办？`  
Voice: `我这台雷鸟鹤6 Ultra，系统识别型号是 T966D5，装 Aerial 时被 TCL 的桌面校验拦截。`

**3–9 s — before/after**  
Use real, same-camera shots of CyberUI and Aerial. Do not use a generated mock screen.  
Voice: `我想保留原厂应用，只换 HOME。`

**9–20 s — the key discovery**  
Show a sanitized terminal/log close-up, with IPs, serials, account names and local paths hidden.  
Voice: `最后发现不是 APK 坏了，而是 TCL 的安装策略没放行这个桌面包。备份策略后，我只临时放行 Aerial，再走电视自己的多屏互动安装入口。`

**20–29 s — proof and boundary**  
Show Aerial version page, Home key, then reboot-to-Aerial proof if freshly recorded.  
Voice: `装好恢复策略后，Aerial 1.46 成为默认 HOME，重启后首次检查已经在 Aerial。原厂 CyberUI 还保留着。`

**29–35 s — honest caveat and CTA**  
On-screen: `单台 T966D5 / Android 14 实测；待机回桌面仍有问题`  
Voice: `这是我这台 T966D5 的实测，不代表所有 TCL。待机唤醒和信号源逐项测试还有问题，完整日志、脱敏记录和回退说明都在 GitHub。评论区留型号，我先查兼容性再讨论怎么试。`

Suggested caption: `一台雷鸟 T966D5 的第三方 HOME 实测：遇到 TCL 安装校验后，通过临时单包策略放行和电视自带安装入口，完成 Aerial 1.46 安装；原厂桌面仍保留。重启自动进入已验证，待机唤醒未通过。完整诊断、脱敏聊天记录和限制见案例仓库。请不要直接照搬别的机型包名。`

## Xiaohongshu carousel draft (8 panels)

1. **Cover:** `雷鸟鹤6 Ultra 换桌面踩坑记录` / `T966D5 · Android 14 · Aerial 1.46` with a real Aerial screen photo.
2. **Before:** CyberUI HOME, photographed straight-on; add a small “原厂桌面” caption.
3. **The blocker:** sanitized installation failure text: `INSTALL_FAILED_VERIFICATION_FAILURE`; explain that the vendor check blocked the HOME-capable APK.
4. **What actually worked:** backup current config → temporary package-specific Aerial exception → MultiScreen push/install → restore the saved config → reboot and check. Keep internals high-level; link the repository for exact evidence.
5. **After:** real Aerial home screen plus version 1.46 screen; note CyberUI remains installed/enabled as fallback.
6. **What passed:** Home behavior and reboot first sample entered Aerial. Use short labels and avoid implying universal compatibility.
7. **What did not pass:** standby wake returned to TCL TV within the tested 60-second window; input enumeration did not run because the API output did not match the test script. This transparency makes the case more reproducible.
8. **Repository + question:** `littleCareless/iffalcon-t966d5-tv-notes` and `https://github.com/littleCareless/iffalcon-t966d5-tv-notes`; ask `你家的品牌、型号、Android 版本是什么？`

Suggested note text:

> 给一台雷鸟鹤6 Ultra（系统识别 T966D5）换 Aerial 桌面，真正卡住我的不是安装包，而是 TCL 的桌面安装校验。经过备份、临时单包放行、电视自带多屏互动安装，再恢复策略，Aerial 1.46 成为默认 HOME；原厂 CyberUI 仍保留。重启后首次检查已进入 Aerial，但待机唤醒测试仍回到 TCL TV，信号源逐项测试也没跑通。完整诊断输出、脱敏会话记录、设备限制和恢复说明都放在公开仓库。只验证了这一台和这一版固件，别把包名或数据库方案直接套到其他电视。

## Screenshot and recording checklist

Capture fresh material from the TV before posting; no screenshot is fabricated or included in the public repository.

There is a local 2026-10-29 post-reboot Aerial capture (`after-batch3-reboot.png`) that can serve as a current HOME visual, but its status bar shows the city, time, and weather, and it does not show the Aerial version. Crop or mask that strip before sharing, and use the diagnostic output separately for the 1.46/version and reboot evidence. Older `before-home.png` material shows a TCL account/membership banner; replace it with a fresh capture or crop that banner out.

- Clear, full-screen CyberUI “before” and Aerial “after”, same camera angle and screen brightness.
- Aerial About/version page showing `1.46`.
- A short continuous recording: press Home from another app, reboot, then film the first visible screen. Do not edit out an intervening manufacturer screen if it appears.
- Sanitized installation error showing the verification failure, if still available.
- Optional: a brief view of the settings/strategy backup and restoration *without* showing raw database contents, local paths, network addresses, device serials, account identity, or ADB keys.
- Do not show a home Wi-Fi list, QR codes that expose local control URLs, the TV's IP, notification banners, personal photos, or account names.
- Do not claim standby or HDMI/source testing passed; the recorded standby test failed and input enumeration was not completed.

## Repo identity and call to action

- Repository: [`littleCareless/iffalcon-t966d5-tv-notes`](https://github.com/littleCareless/iffalcon-t966d5-tv-notes)
- Suggested short repo description: `A documented, reversible Aerial HOME setup and TCL T966D5 Android 14 diagnostic case. Single-device evidence; no universal debloat list.`
- Link directly to [Aerial HOME notes](aerial-home.md), [full diagnostics](../diagnostics/2026-10-29-report.sh.md), [self-test and correction](../diagnostics/2026-10-29-selftest.sh.md), and [redacted conversation](conversation-redacted.md).

## Sources and evidence limits

- Viral post and engagement figures: secondary article snapshots; counts vary over time and were not independently checked against the original platform post.
- Xiaomi troubleshooting article: a detailed first-person technical account, useful for story structure and troubleshooting narrative; it is a different TV and its findings do not prove anything about this TCL.
- Aerial project: primary source for its own installation flow, supported-device notes and feature claims. The case above relies on this television's own observed diagnostics for results.
