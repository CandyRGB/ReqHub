# 已知问题 & 注意事项

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

- `lib/app.dart` — 全局主题定义，`_cjkFallback: ['Microsoft YaHei', 'Source Han Sans SC', 'Noto Sans SC', 'sans-serif']`
- `lib/screens/settings_screen.dart` — 唯一受影响的文件，已于 2026-06-14 修复
