# 雷鸟鹤 6 Ultra（2027 款，85 英寸）电视实机记录

这份仓库记录一台雷鸟鹤 6 Ultra 2027 款 85 英寸电视的实机适配、Aerial 桌面、应用安装、可逆停用试验、诊断结果和恢复方法。商品型号由设备所有者提供；系统识别到的硬件与固件信息见[设备档案](docs/device-profile.md)。

> **单机案例，不是通用 TCL 精简清单。** 同一商品系列不同尺寸、批次、主板和固件可能采用不同芯片、服务及系统策略。请先核对设备档案，不要直接照搬停用包或安装命令。

本记录参考了 [FFALCON/TCL T982 清理与换桌面实录](https://github.com/bozhang0419/ffalcon-t982-debloat) 的结构，涵盖设备与固件、实测结果、可逆操作、回滚和经验。该项目针对 T982 / Android 11；本机硬件与系统不同，不能直接套用其包名、结论或命令。

## 实机方案：将 Aerial 设为系统默认 HOME

这台雷鸟鹤 6 Ultra（系统识别为 T966D5 / Android 14 / AU01）最终通过官方 Aerial **standard** 版实现真正的默认 HOME。我们在 Aerial 上游提交的 [Issue #420](https://github.com/pengchujin/aerial-tv/issues/420) 记录了适配背景、实测结果和更细的复现材料；下方是本仓库的简明方案。

1. **先核对机型和固件。** 下面流程只在本仓库记录的 T966D5 / Android 14 / `UTT2.250416.001 AU01` 上实测。备份原始 HOME、启动项、完整安装配置及缓存、应用状态；其他机型或配置结构不同，应先停下来重新调查。
2. **通过电视内置多屏互动安装通道，并临时放行 Aerial。** 普通 ADB 安装 Aerial standard 会被本固件的 TCL 桌面签名校验拒绝。排查后确认，TCL 在 `content://com.tcl.providers.config/InstallConfig` 提供安装策略配置；其中 `launcherStrategy.packages` 是 **TCL 自己的桌面应用安装白名单**，不是 Android 通用设置。实机读取到的相关配置项类似：

   ```json
   {"enable":"true","name":"launcherStrategy","packages":[],"priority":"3"}
   ```

   安装时只将这个项目的 `packages` 从空列表临时改为 `["app.orchard.tv"]`，让 Aerial 通过该桌面安装策略中的厂商签名检查；其他策略和整体校验保持原样。这个白名单**只影响安装是否放行，不会把 Aerial 设为默认 HOME**；默认 HOME 是后续单独通过 Android 的 `cmd package set-home-activity` 设置的。上面的 JSON 只是相关配置项示例，**不能当作完整配置直接写回**。

   本机的 TCL 配置服务会缓存策略：只改数据库可能不会更新 FeatureCache，安装器仍可能读到旧值。因此实测先备份完整原配置、缓存及权限状态，再只改这一项；正常重启后同时读回数据库和 FeatureCache，确认都加载了临时白名单，才继续安装。安装成功或失败后都恢复原配置并再次重启，逐项核对数据库与缓存均与备份一致。不要长期保留临时白名单，也不要只恢复数据库就认为已经恢复完成。更细的实机诊断与复现材料见 [Aerial Issue #420](https://github.com/pengchujin/aerial-tv/issues/420)。确认临时值生效后，再由多屏互动推送官方 standard APK，并在电视弹窗上确认安装。
3. **把 Aerial 登记为默认 HOME。** 核实安装包、签名/版本及 HOME 活动后执行：

   ```sh
   adb -s TV_ADB_ADDRESS:5555 shell cmd package set-home-activity --user 0 app.orchard.tv/.MainActivity
   adb -s TV_ADB_ADDRESS:5555 shell cmd package resolve-activity --brief -a android.intent.action.MAIN -c android.intent.category.HOME
   ```

   将 `TV_ADB_ADDRESS:5555` 替换成操作者自己的 ADB 地址。解析结果应指向 `app.orchard.tv/.MainActivity`。原厂 CyberUI 保留安装并启用，系统安装器也始终保持启用。
4. **还原临时白名单并复核。** 安装成功或失败都恢复完整原始配置，重启后逐字核对数据库和 FeatureCache 与备份一致；同时复查原机应用状态。不要把安装白名单长期留在放宽状态。
5. **单独核对开机目标。** 本机记录到 TCL 的 `boot_app_componentname` 是独立启动项。先备份并读取 `boot_app_mode` 与原启动目标；本机保持 `boot_app_mode=boot_launcher`，将目标改为 Aerial 后重启验收：

   ```sh
   adb -s TV_ADB_ADDRESS:5555 shell settings get system boot_app_mode
   adb -s TV_ADB_ADDRESS:5555 shell settings get system boot_app_componentname
   # 仅当原模式/当前机型与本案例相符，且已备份原值时才设置：
   adb -s TV_ADB_ADDRESS:5555 shell settings put system boot_app_componentname app.orchard.tv/.MainActivity
   ```

**实测结果：** 实体 Home 键直接进入 Aerial，不再闪过 CyberUI；重启后用户未按 Home，电视自动进入 Aerial。两项结果分别验收。启动日志曾显示解锁后由 AerialGuard 接管，因此不能据此保证开机每个阶段都不出现原桌面，也不能断言单独修改启动项就是唯一原因；长期稳定性及其他机型尚未验证。

Android 11 / T982 社区案例里的“临时停用 `com.android.packageinstaller`”不适用于本机：Android 14 会保护系统安装器。本方案不依赖停用安装器、关闭总体验证、卸载原桌面或删除原机应用。完整证据见 [Issue #420](https://github.com/pengchujin/aerial-tv/issues/420) 与 [Aerial HOME 实机记录](docs/aerial-home.md)。

## 设备与当前记录

- 商品型号：雷鸟鹤 6 Ultra，2027 款，85 英寸（所有者提供）。
- 系统识别：IFFALCON/TCL，设备代号 `T966D5`，产品名 `T966D5_4K_CN`，平台 `t6x` / `amlogic`。
- 固件：Android 14 / SDK 34，构建号 `UTT2.250416.001 AU01`；约 2 GB RAM，32 位 ARM。
- Aerial 1.69（`app.orchard.tv/.MainActivity`）已设为 HOME。所有者确认重启后未按 Home 键即自动进入 Aerial。
- 18 个 TCL 包使用 `pm disable-user --user 0` 停用，没有卸载或删除原机应用。
- 一次重启后，TCL 更新器重新启用了 `com.tcl.ffeducation`；随后再次停用，但这次再次停用后的重启尚未验证。
- 最近一次记录中，电视输入、飞牛影视、多屏互动、Android 安装器、权限控制器和 Aerial HomeGuard 均处于启用状态。

## 目录

- [设备档案与操作边界](docs/device-profile.md)
- [Aerial HOME 实机记录](docs/aerial-home.md)
- [T966D5 Aerial 机型适配复测稿（未提交）](docs/aerial-adapt-T966D5.md)
- [停用包记录与影响](docs/debloat.md)
- [应用与 TVBox 记录](docs/apps-and-tvbox.md)
- [备份范围与恢复方法](docs/backup-and-recovery.md)
- [操作日志](docs/operation-log.md)
- [`report.sh` 1.69 诊断输出全文](diagnostics/2026-10-29-report.sh.md)
- [`report.sh` 1.46 历史诊断](diagnostics/2026-10-29-report-v1.46.md)
- [`selftest.sh` 1.46 首次失败输出及误报更正](diagnostics/2026-10-29-selftest.sh.md)
- [`selftest.sh` 1.69 待机/重启/输入复测全文](diagnostics/2026-10-29-selftest-rerun.sh.md)
- [`selftest.sh` 1.46 历史复测](diagnostics/2026-10-29-selftest-v1.46-rerun.md)
- [本会话可见聊天记录（脱敏）](docs/conversation-redacted.md)
- [社交媒体案例文案](docs/social-media-kit.md)
- [四篇平台发布包（抖音/小红书视频与图文）](docs/social-campaign/README.md)
- [恢复停用包脚本](scripts/restore-packages.sh)

## 安全与隐私

仓库不包含电视网络地址、序列号、ADB 密钥、账户凭据、完整系统设置转储、TCL 配置数据库/缓存、应用数据、截图、APK 或本机备份。诊断文件只保留本案例所需的系统字段；HDMI 自定义设备名、本机路径和网络地址均已脱敏。聊天记录包含用户与助手可见消息，不包含隐藏推理或工具内部载荷。六个受保护的系统/厂商 overlay APK 无法由非特权 ADB 读取；备份限制详见[备份与恢复](docs/backup-and-recovery.md)。

本仓库内容采用 [MIT License](LICENSE)。电视固件、Aerial 等第三方软件及其商标不在本仓库许可证授权范围内。
