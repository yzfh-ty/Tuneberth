# Tuneberth（听泊）

项目仓库：[yzfh-ty/Tuneberth](https://github.com/yzfh-ty/Tuneberth)。

项目路径：`E:\project\flutter\Tuneberth`。Flutter 工程名为 `tuneberth`，Android 包名为 `de.tyverse.tuneberth`。

Flutter 客户端框架，目标平台为 Windows、Linux、Android。新版本计划使用 115 OpenAPI，音乐库也为本地文件夹预留了接口。

目前包含黑白灰深浅主题、桌面侧栏与手机底部导航、音乐库/收藏/歌单/设置空状态，以及认证凭据、OpenAPI、音乐仓储和播放引擎的接口。界面沿用旧项目的应用图标和主题色。

账号连接、文件夹选择、标签解析、数据库、实际音频播放与系统媒体控制尚未接入；对应按钮保持禁用。主题切换当前只在本次运行中生效。框架中没有 Cookie 客户端、Go 服务、自研 Rust 模块或内置 AppSecret。

## 开发

生成时使用 Flutter 3.47.5 / Dart 3.13.4。先安装与 `pubspec.yaml` 兼容的 Flutter SDK：

```powershell
flutter pub get
flutter run -d windows
```

Linux 在带图形桌面的 Linux 环境运行 `flutter run -d linux`；Android 在连接设备后运行 `flutter run -d <device-id>`。三端分别需要其平台工具链。

```powershell
dart format --output=none --set-exit-if-changed lib test
flutter analyze
flutter test
```

## 目录

```text
lib/
  app/                         应用入口、主题和自适应导航
  core/auth/                   token 模型及安全存储接口
  core/network/                OpenAPI 访问接口
  features/library/domain/     曲目模型和音乐仓储接口
  features/playback/domain/    临时播放源与播放引擎接口
  features/playback/presentation/
  features/settings/presentation/
  shared/widgets/              共用空状态组件
android/ windows/ linux/       Flutter 生成的平台工程
assets/images/                原应用图标
test/                         导航、主题及多视口验证
tmp/
  legacy-qt/                  旧 PySide6/QML 实现及未提交修改归档
  reference-projects/openlist/ OpenList 官方参考源码
  Tuneberth-OpenAPI技术选型.md   技术评估和后续迁移方案
```

`tmp/`、构建缓存、IDE 文件、签名文件和本地凭据均已忽略。Flutter 平台源码、`pubspec.lock` 和应用资源属于需要追踪的项目文件。

## 本次验证

- Dart 格式检查和 `flutter analyze` 通过。
- 375×812、768×1024、1280×800 下的导航和设置布局检查通过，主题切换检查通过；另生成四张 Flutter 渲染截图，共 8 项测试通过。
- Windows Debug 编译和启动检查通过；测试进程已关闭，无监听端口残留。
- Android/Linux 平台工程已生成，尚未在对应平台编译或运行。

实际截图和验证说明保存在 `tmp/flutter-qa/`。独立视觉评审服务返回错误，本次进行了截图自查，未完成独立视觉评审。

## 参考源码

OpenList 来源为 <https://github.com/OpenListTeam/OpenList>，保留 `main` 分支源码快照，迁移时已移除其 `.git` 历史。115 OpenAPI 驱动位于 `tmp/reference-projects/openlist/drivers/115_open/`；其调用还依赖独立的 115 SDK，参见参考项目 `go.mod`。该项目仅用于阅读参考，不参与 Flutter 编译。

归档详情见 `tmp/legacy-qt/归档说明.md`；设计取舍见 `tmp/Flutter框架设计说明.md`。

## 开发文档

详细中文 Markdown 文档见 [文档索引](tmp/docs/README.md)，包含项目状态、架构与接口、运行构建、OpenAPI/OpenList 参考、旧版迁移和测试验收。文档保存在被 Git 忽略的 `tmp/` 下，可在本地 Obsidian 阅读。

迁移结果、包名调整和新路径验证见 [项目迁移记录](tmp/migration-tuneberth/迁移说明.md)。新仓库没有继承旧 Git 历史；`origin` 已配置为上述 GitHub 仓库。
