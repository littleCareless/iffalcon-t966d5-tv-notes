# 雷鸟鹤 6 Ultra（2027 款，85 英寸）电视实机记录

这份仓库记录一台雷鸟鹤 6 Ultra 2027 款 85 英寸电视的实机适配、Aerial 桌面、应用安装、可逆停用试验、诊断结果和恢复方法。商品型号由设备所有者提供；系统识别到的硬件与固件信息见[设备档案](docs/device-profile.md)。

> **单机案例，不是通用 TCL 精简清单。** 同一商品系列不同尺寸、批次、主板和固件可能采用不同芯片、服务及系统策略。请先核对设备档案，不要直接照搬停用包或安装命令。

本记录参考了 [FFALCON/TCL T982 清理与换桌面实录](https://github.com/bozhang0419/ffalcon-t982-debloat) 的结构，涵盖设备与固件、实测结果、可逆操作、回滚和经验。该项目针对 T982 / Android 11；本机硬件与系统不同，不能直接套用其包名、结论或命令。

## 设备与当前记录

- 商品型号：雷鸟鹤 6 Ultra，2027 款，85 英寸（所有者提供）。
- 系统识别：IFFALCON/TCL，设备代号 `T966D5`，产品名 `T966D5_4K_CN`，平台 `t6x` / `amlogic`。
- 固件：Android 14 / SDK 34，构建号 `UTT2.250416.001 AU01`；约 2 GB RAM，32 位 ARM。
- Aerial 1.46（`app.orchard.tv/.MainActivity`）已设为 HOME。所有者确认重启后未按 Home 键即自动进入 Aerial。
- 18 个 TCL 包使用 `pm disable-user --user 0` 停用，没有卸载或删除原机应用。
- 一次重启后，TCL 更新器重新启用了 `com.tcl.ffeducation`；随后再次停用，但这次再次停用后的重启尚未验证。
- 最近一次记录中，电视输入、飞牛影视、多屏互动、Android 安装器、权限控制器和 Aerial HomeGuard 均处于启用状态。

## 目录

- [设备档案与操作边界](docs/device-profile.md)
- [Aerial HOME 实机记录](docs/aerial-home.md)
- [停用包记录与影响](docs/debloat.md)
- [应用与 TVBox 记录](docs/apps-and-tvbox.md)
- [备份范围与恢复方法](docs/backup-and-recovery.md)
- [操作日志](docs/operation-log.md)
- [`report.sh` 诊断输出全文](diagnostics/2026-10-29-report.sh.md)
- [`selftest.sh` 诊断输出全文及结果更正](diagnostics/2026-10-29-selftest.sh.md)
- [本会话可见聊天记录（脱敏）](docs/conversation-redacted.md)
- [社交媒体案例文案](docs/social-media-kit.md)
- [恢复停用包脚本](scripts/restore-packages.sh)

## 安全与隐私

仓库不包含电视网络地址、序列号、ADB 密钥、账户凭据、完整系统设置转储、TCL 配置数据库/缓存、应用数据、截图、APK 或本机备份。诊断文件只保留本案例所需的系统字段；HDMI 自定义设备名、本机路径和网络地址均已脱敏。聊天记录包含用户与助手可见消息，不包含隐藏推理或工具内部载荷。六个受保护的系统/厂商 overlay APK 无法由非特权 ADB 读取；备份限制详见[备份与恢复](docs/backup-and-recovery.md)。

仓库当前未附许可证；复用权限尚未指定。
