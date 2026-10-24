# 已知问题 & 注意事项

## Windows 中文半粗体过重（已修复）

Segoe UI 不包含中文字符，中文会交给回退字体。Windows 的 Microsoft YaHei 只有 Light、Regular、Bold，600 字重会匹配到 700。小字号标题、按钮和表头因此容易显得过粗。

界面现已统一使用随软件打包的 Noto Sans SC 可变字体（字体族 `ReqHubSans`），提供真实的 400、500、600、700 等字重。Flutter 3.41 及以上会自动将 `FontWeight` 映射到 `wght` 轴。

- 全局字体和回退链定义在 `lib/config/app_typography.dart`，由 `lib/config/app_theme.dart` 统一应用到正文、按钮、标签和提示。
- 字体文件与许可证位于 `assets/fonts/`，无需用户安装字体或联网下载。
- 代码区域保持 JetBrains Mono，中文字符回退到同一个界面字体。
- 新增组件应继承主题字体；避免显式设置 Segoe UI 或微软雅黑，否则中文半粗体可能再次退化。
- `test/widgets/app_typography_test.dart` 会检查字体的原生字重轴，以及中文四档字重的实际渲染差异。

## DropdownButton 字体会绕过全局 CJK 回退

### 问题

`DropdownButton` 使用 `const TextStyle(fontSize: 14)` 这样的裸 `TextStyle` 时，
不会自动继承全局主题中通过 `textTheme.apply(fontFamilyFallback: [...])` 设置的中文字体回退链，
导致中文文本可能以日文字体渲染。

### 原因

`DropdownButton` 内部渲染选中值时，其文本样式继承链与普通 `Text` widget 不同。
如果通过 `style` 参数传入一个未设置 `fontFamily` / `fontFamilyFallback` 的 `TextStyle`，
Flutter 会使用系统默认字体而非主题中配置的 CJK 回退字体。

### 修复方法

不要使用裸 `TextStyle(...)`，改为从主题的 textTheme 继承：

```dart
// ❌ 错误 — 不会继承 CJK 字体回退
style: TextStyle(fontSize: 14, color: cs.onSurface),

// ✅ 正确 — 从主题继承，包含 fontFamilyFallback
style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14),
```

### 影响范围

- `DropdownButton` 的 `style` 参数（显式传入裸 `TextStyle` 时）
- 项目其余 `DropdownButton`（`auth_editor`, `body_editor`, `url_bar`）均未设置 `style`，使用主题默认，不受影响
- 普通 `Text` widget 上的 `const TextStyle(...)` 不受影响 —— 它们正常继承 `DefaultTextStyle`

### 相关文件

- `lib/config/app_typography.dart`、`lib/config/app_theme.dart` — 当前全局字体和主题定义。
- `lib/screens/settings_screen.dart` — 历史受影响位置；当前使用主题化的分段按钮。
