# ReqHub 架构文档

## 一、项目概述

ReqHub 是一款基于 Flutter (Windows) 的 HTTP 客户端工具，类似 Postman / Insomnia。核心功能：

- 请求集合的树形管理（Collection / Request 二级嵌套）
- 多标签页编辑与发送 HTTP 请求
- cURL 导入 / 导出
- 应用设置持久化（主题、超时、SSL、代理）

---

## 二、分层架构

```
┌─────────────────────────────────────────────────────────────────┐
│  UI 层 (widgets / screens)                                      │
│  MainScreen → SidebarPanel → CollectionTree → TreeItemTile      │
│                         │              ├─ DraggableTreeItem      │
│                         │              ├─ InlineEditField         │
│                         │              └─ showTreeContextMenu    │
│            RequestPage → UrlBar / BodyEditor / HeadersEditor…   │
│            SettingsScreen                                       │
├─────────────────────────────────────────────────────────────────┤
│  State 层 (providers)                                           │
│  collectionsProvider   ── 集合树 CRUD + 持久化                  │
│  requestTabsProvider   ── 多标签页生命周期 + 请求发送            │
│  currentRequestProvider ── 派生：活跃标签的 request（只读）      │
│  responseProvider       ── 派生：活跃标签的 response（只读）     │
│  settingsProvider       ── 应用设置 + 持久化                     │
│  appThemeProvider       ── 派生：从 settings 派生 ThemeMode      │
│  httpServiceProvider    ── watch settings → 自动 configure        │
├─────────────────────────────────────────────────────────────────┤
│  Service 层                                                     │
│  HttpService     ── Dio 封装，发送请求                           │
│  StorageService  ── 文件系统读写（JSON）                         │
│  CurlParser      ── cURL 字符串 → HttpRequestModel              │
│  CurlGenerator   ── HttpRequestModel → cURL 字符串              │
│  ExportService   ── 数据导出                                     │
├─────────────────────────────────────────────────────────────────┤
│  Model 层 (Freezed)                                             │
│  Collection / HttpRequestModel / HttpResponseModel               │
│  RequestBody (sealed) / AuthConfig (sealed) / KeyValuePair      │
│  AppSettings / ResponseCookie                                    │
└─────────────────────────────────────────────────────────────────┘
```

**依赖方向**：UI → Provider → Service → Model，无跨层调用。

---

## 三、数据流

### 3.1 集合树数据流

```
StorageService.loadCollections()
       ↓
CollectionsNotifier.init()  →  RootState { collections, rootRequests }
       ↓
SidebarPanel watches collectionsProvider
       ↓
CollectionTree 接收 collections / rootRequests 作为 props
       ↓
flattenTree() 扁平化为 List<TreeEntry>
       ↓
ListView.builder 渲染 TreeItemTile
```

### 3.2 请求编辑数据流

```
SidebarPanel.onRequestSelected / onRequestNamed
       ↓
MainScreen._onRequestSelected → requestTabsProvider.openTab(request)
       ↓
RequestTabsState { tabs, activeIndex }
       ↓
currentRequestProvider = 派生自 requestTabsProvider（只读）
responseProvider       = 派生自 requestTabsProvider（只读）
       ↓
RequestPage / UrlBar / BodyEditor 读取 currentRequestProvider
       ↓
用户编辑 → requestTabsProvider.updateActiveXxx()
       ↓
标签内 request 更新 → 派生 Provider 自动同步
```

### 3.3 设置数据流

```
SettingsScreen  →  settingsProvider.setXxx()
       ↓
AppSettings 持久化到 StorageService
       ↓
appThemeProvider 派生 ThemeMode → FluentApp 响应主题
httpServiceProvider watch settings → 自动 configure Dio
```

### 3.4 Provider 依赖关系

```
storageServiceProvider (单例)
    ↓
┌───────────────────────┬────────────────────┐
collectionsProvider     settingsProvider
(依赖 StorageService)    (依赖 StorageService)
                         ↓
                    appThemeProvider (派生)
                    httpServiceProvider (watch)
                         ↓
requestTabsProvider (依赖 Ref → 读取 httpServiceProvider)
    ↓
currentRequestProvider (派生)
responseProvider (派生)
```

---

## 四、侧边栏模块详解

### 4.1 文件职责

| 文件 | 行数 | 类型 | 职责 |
|---|---|---|---|
| `sidebar_panel.dart` | 267 | ConsumerStatefulWidget | 侧边栏容器：标题、Toolbar、Tree、Settings 入口；管理选中/编辑状态 |
| `collection_tree.dart` | 314 | ConsumerStatefulWidget | 树编排器：扁平化调度、选择、展开/折叠、右键菜单分发、内联编辑 |
| `tree_entry.dart` | 25 | 纯数据类 | `TreeEntry` + `TreeEntryKind` 枚举 |
| `tree_flattener.dart` | 61 | 纯函数 | `flattenTree()` 将嵌套结构扁平化为线性列表 |
| `tree_item_tile.dart` | 117 | StatelessWidget | 单行渲染：chevron、文件夹图标、标签、方法徽章 |
| `tree_inline_editor.dart` | 34 | StatelessWidget | 内联重命名文本框 `InlineEditField` |
| `tree_context_menu.dart` | 54 | 纯函数 | `showTreeContextMenu()` 构建右键菜单 |
| `tree_drag_handler.dart` | 123 | ConsumerStatefulWidget | `DraggableTreeItem` 拖拽排序 + 自动展开 + 循环检测 |

### 4.2 组件层次

```
SidebarPanel
├── 标题 "ReqHub"
├── Toolbar（New Request / Import cURL / New Collection / Copy / Rename / Delete）
├── CollectionTree
│   ├── DragTarget（根级拖放）
│   └── ListView.builder
│       └── MouseRegion → DraggableTreeItem → TreeItemTile
│                                              └── InlineEditField（编辑态）
├── Divider
└── Settings 链接
```

### 4.3 状态归属

| 状态 | 归属 | 说明 |
|---|---|---|
| `_selectedRequestId` / `_selectedCollectionId` | `SidebarPanel` | 当前选中节点 |
| `_editingId` / `_editingIsNew` | `SidebarPanel` | 当前编辑节点 |
| `_entries` / `_expanded` / `_selectedId` / `_hoveredId` | `CollectionTree` | 树内部 UI 状态 |
| `_editController` / `_editFocusNode` | `CollectionTree` | 内联编辑控制器 |

### 4.4 数据修改通道

当前 `CollectionTree` 存在两种数据修改通道：

| 操作 | 通道 | 路径 |
|---|---|---|
| 选择节点 | 回调 | `CollectionTree` → `SidebarPanel.onRequestSelected` |
| 内联编辑提交 | Provider 直连 | `CollectionTree._commitEdit()` → `notifier.renameItem/delete` |
| 右键菜单操作 | Provider 直连 | `CollectionTree._showMenu()` → `notifier.addRequest/addCollection/delete/duplicate` |
| 拖拽移动 | Provider 直连 | `DraggableTreeItem` → `notifier.moveCollection/moveRequest` |
| 根级拖放 | Provider 直连 | `CollectionTree.build()` → `notifier.moveCollection` |
| Toolbar 操作 | Provider 直连 | `SidebarPanel._newRequest/_delete/...` → `notifier.xxx` |

**注意**：选择操作走回调上报，其余操作直接访问 Provider。这意味着 `SidebarPanel` 无法感知右键菜单/拖拽/内联编辑产生的数据变更。

---

## 五、Provider 设计

### 5.1 CollectionsNotifier (357 行)

**职责**：集合树的全部 CRUD + 移动 + 重命名 + 持久化。

**公开方法**：

| 方法 | 说明 |
|---|---|
| `init()` | 从 StorageService 加载数据 |
| `addCollection(name, parentId?)` | 新增集合，返回 id |
| `addRequest(collectionId?, request)` | 新增请求，返回 id |
| `updateRequest(id, updated)` | 更新请求 |
| `deleteRequest(id)` | 删除请求 |
| `deleteCollection(id)` | 删除集合 |
| `moveRequest(id, targetCollectionId?)` | 移动请求 |
| `moveCollection(id, targetParentId?)` | 移动集合（含循环检测） |
| `renameItem(id, newName)` | 重命名（自动判断集合/请求） |
| `duplicateRequest(id)` | 复制请求，返回新 id |
| `findCollection(id)` | 按 id 查找集合 |
| `findRequest(id)` | 按 id 查找请求 |
| `findRequestParentId(id)` | 查找请求的父集合 id |
| `isDescendantOf(ancestorId, descendantId)` | 判断后代关系 |
| `exportCollections()` / `importData()` | 导入导出 |

**状态结构**：
```dart
class RootState {
  List<Collection> collections;   // 根级集合
  List<HttpRequestModel> rootRequests;  // 根级请求（不属于任何集合）
}
```

### 5.2 RequestTabsNotifier (180 行)

**职责**：多标签页生命周期管理 + 请求发送。

**核心设计**：`RequestTabData` 同时持有 `request` 和 `response`，作为标签的完整状态单元。`currentRequestProvider` 和 `responseProvider` 从此 Provider 派生，无需手动同步。

**公开方法**：

| 方法 | 说明 |
|---|---|
| `openTab(request)` | 打开/切换到标签 |
| `createNewTab(collectionId?)` | 创建空白标签 |
| `activateTab(index)` | 切换活跃标签 |
| `closeTab(index)` | 关闭标签 |
| `sendActiveRequest()` | 发送当前请求 |
| `updateActiveMethod/Url/Name/Headers/...` | 字段级编辑 |

### 5.3 派生 Provider

```dart
// 从活跃标签派生当前请求（只读）
currentRequestProvider = Provider((ref) {
  final tabs = ref.watch(requestTabsProvider);
  return tabs.isEmpty ? null : tabs.activeTab.request;
});

// 从活跃标签派生当前响应（只读）
responseProvider = Provider((ref) {
  final tabs = ref.watch(requestTabsProvider);
  return tabs.isEmpty ? null : tabs.activeTab.response;
});

// 从设置派生主题（只读）
appThemeProvider = Provider((ref) {
  final settings = ref.watch(settingsProvider);
  return _mapThemeMode(settings.themeMode);
});

// HTTP 服务：watch settings 自动重配
httpServiceProvider = Provider((ref) {
  final settings = ref.watch(settingsProvider);
  final service = HttpService();
  service.configure(
    followRedirects: settings.followRedirects,
    timeoutSeconds: settings.timeoutSeconds,
    verifySsl: settings.verifySsl,
    proxyUrl: settings.proxyUrl,
  );
  return service;
});
```

---

## 六、Model 设计

全部使用 Freezed 生成不可变类，支持 `copyWith` / `fromJson` / `toJson`。

| Model | 说明 |
|---|---|
| `Collection` | 递归嵌套集合：`children: List<Collection>` + `requests: List<HttpRequestModel>` |
| `HttpRequestModel` | HTTP 请求完整定义 |
| `HttpResponseModel` | HTTP 响应 |
| `RequestBody` | Sealed class：`NoneBody / JsonBody / FormDataBody / UrlEncodedBody / RawBody / BinaryBody` |
| `AuthConfig` | Sealed class：`NoAuth / BasicAuth / BearerAuth / ApiKeyAuth` |
| `KeyValuePair` | 通用键值对（headers / queryParams），含 `enabled` 标志 |
| `AppSettings` | 应用设置，`ThemeMode` 为自定义枚举 |
| `ResponseCookie` | 响应 Cookie |

---

## 七、Service 设计

| Service | 说明 |
|---|---|
| `HttpService` | Dio 封装，支持 JSON / Form / URL-encoded / Raw / Binary body，Auth 自动注入 |
| `StorageService` | JSON 文件读写，默认路径 `%APPDATA%/ReqHub/` |
| `CurlParser` | cURL 字符串解析，支持 `-X/-H/-d/-u/--url` 等常见 flag |
| `CurlGenerator` | 从请求模型生成 cURL 命令 |
| `ExportService` | 数据导出 |

---

## 八、路由

```
/           → MainScreen（主界面：SidebarPanel + TabView）
/settings   → SettingsScreen（设置页）
```

使用 `go_router` 管理。

---

## 九、文件清单

```
lib/
├── app.dart                              # FluentApp 入口，路由配置
├── main.dart                             # void main()
├── config/
│   └── colors.dart                       # 全局颜色常量
├── models/
│   ├── app_settings.dart                 # AppSettings + ThemeMode 枚举
│   ├── collection.dart                   # Collection（递归嵌套）
│   ├── http_request.dart                 # HttpRequestModel + AuthConfig (sealed)
│   ├── http_response.dart                # HttpResponseModel + ResponseCookie
│   ├── key_value_pair.dart               # KeyValuePair
│   └── request_body.dart                 # RequestBody (sealed)
├── providers/
│   ├── providers.dart                    # 所有 Provider 注册 + 派生 Provider
│   ├── collections_provider.dart         # CollectionsNotifier + RootState
│   ├── request_tabs_provider.dart        # RequestTabsNotifier + RequestTabData + RequestTabsState
│   └── settings_provider.dart            # SettingsNotifier
├── screens/
│   ├── main_screen.dart                  # 主界面
│   └── settings_screen.dart              # 设置页
├── services/
│   ├── curl_generator.dart               # 请求 → cURL
│   ├── curl_parser.dart                  # cURL → 请求
│   ├── export_service.dart               # 数据导出
│   ├── http_service.dart                 # Dio 封装
│   └── storage_service.dart              # 文件系统持久化
└── widgets/
    ├── context_menu.dart                 # 通用右键菜单组件
    ├── request/
    │   ├── auth_editor.dart              # Auth 编辑器
    │   ├── body_editor.dart              # Body 编辑器
    │   ├── headers_editor.dart           # Headers 编辑器
    │   ├── params_editor.dart            # Query Params 编辑器
    │   ├── request_page.dart             # 请求编辑页（UrlBar + 选项卡 + 响应）
    │   ├── request_tab.dart              # 请求选项卡容器
    │   └── url_bar.dart                  # URL + Method 输入栏
    ├── response/
    │   ├── response_body_viewer.dart     # 响应体查看器
    │   ├── response_headers_viewer.dart  # 响应头查看器
    │   ├── response_pane.dart            # 响应面板
    │   └── response_status_bar.dart      # 状态码栏
    └── sidebar/
        ├── sidebar_panel.dart            # 侧边栏容器
        ├── collection_tree.dart          # 集合树编排器
        ├── tree_entry.dart               # TreeEntry 数据类
        ├── tree_flattener.dart           # 树扁平化纯函数
        ├── tree_item_tile.dart           # 树行渲染组件
        ├── tree_inline_editor.dart       # 内联编辑组件
        ├── tree_context_menu.dart        # 右键菜单纯函数
        └── tree_drag_handler.dart        # 拖拽排序组件
```
