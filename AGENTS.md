# AGENTS.md

This file provides guidance to Codex (Codex.ai/code) when working with code in this repository.

## Project

ReqHub — a Postman-like HTTP API client as a Flutter Windows desktop app, using `fluent_ui` for Fluent Design styling.

## Commands

```bash
# Generate freezed + json_serializable code (run after any model change)
dart run build_runner build --delete-conflicting-outputs

# Static analysis
flutter analyze

# Run on Windows
flutter run -d windows

# Build Windows release (requires Developer Mode enabled)
flutter build windows

# Run tests
flutter test
```

## Architecture

### Data flow
```
models/ (freezed immutable) → providers/ (Riverpod StateNotifier) → widgets/ (ConsumerWidget)
                                      ↕
                               services/ (Dio, file I/O, curl parsing)
```

### Models (`lib/models/`)
Freezed data classes with JSON serialization. All models are immutable — use `.copyWith()` to update. Key types:
- `Collection` — tree node (folder), can contain sub-collections and requests
- `HttpRequestModel` — method, URL, headers, query params, body, auth config
- `RequestBody` — sealed class union: `NoneBody | JsonBody | FormDataBody | UrlEncodedBody | RawBody | BinaryBody`
- `AuthConfig` — sealed class: `NoAuth | BasicAuth | BearerAuth | ApiKeyAuth`
- `HttpResponseModel` — status code, headers, body, timing

### Services (`lib/services/`)
- `StorageService` — reads/writes `reqhub_data.json` and `reqhub_settings.json` to `%APPDATA%/ReqHub/` (configurable)
- `HttpService` — wraps Dio, handles all request body types and auth configuration
- `CurlParser` — tokenizes and parses curl commands into `HttpRequestModel`
- `CurlGenerator` — reverse: `HttpRequestModel` → curl command string
- `ExportService` — export/import collections as JSON files

### Providers (`lib/providers/`)
All state managed via Riverpod `StateNotifier`. Provider instances are in `providers.dart`:
- `collectionsProvider` — CRUD for the collection tree + requests
- `currentRequestProvider` — the request currently being edited (nullable)
- `responseProvider` — `AsyncValue<HttpResponseModel?>` after sending
- `settingsProvider` — persisted app settings (storage path, theme, timeout, SSL)
- `appThemeProvider` — light/dark/system theme toggle

### UI (`lib/screens/`, `lib/widgets/`)
- `MainScreen` — custom `Row` layout: sidebar (260px) + request editor + response panel. Uses `fluent_ui` widgets for inputs/dialogs, `Material` widgets for sidebar and notifications.
- `SettingsScreen` — simple `Column` layout: header with back button + settings form.

## Fluent UI caveats

- **`NavigationView`**: cannot pass both `pane` and `content`. Use custom layout (`Row`/`Column`) when you need both a persistent sidebar and a content area.
- **`TabView`**: fluent_ui uses `TabView(tabs: [Tab(text:, body:)])` — tabs include their own bodies, no separate `TabBar` + `IndexedStack`.
- **`Checkbox`**: uses `checked:` not `value:`.
- **`ComboBox`**: uses `items:` with `ComboBoxItem(value:, child:)` — `value` must match the selected type.
- **Icons**: `fluent.FluentIcons.folder`, `fluent.FluentIcons.settings`, `fluent.FluentIcons.back`, `fluent.FluentIcons.add`, `fluent.FluentIcons.delete`.
- Widgets NOT in fluent_ui that require `import 'package:flutter/material.dart' show ...;`: `showDialog`, `showMenu`, `PopupMenuItem`, `SnackBar`, `ScaffoldMessenger`, `Divider`, `SelectableText`, `ListTile`.
