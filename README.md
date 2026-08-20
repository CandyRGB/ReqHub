<p align="center">
  <strong>ReqHub</strong>
</p>

<p align="center">A lightweight HTTP API client for Windows.</p>

<p align="center">
  <a href="https://github.com/CandyRGB/ReqHub"><img alt="GitHub repository" src="https://img.shields.io/badge/GitHub-CandyRGB%2FReqHub-181717?style=flat-square&logo=github" /></a>
  <a href="https://flutter.dev"><img alt="Flutter" src="https://img.shields.io/badge/Flutter-Windows-02569B?style=flat-square&logo=flutter&logoColor=white" /></a>
  <a href="https://dart.dev"><img alt="Dart" src="https://img.shields.io/badge/Dart-3.11%2B-0175C2?style=flat-square&logo=dart&logoColor=white" /></a>
  <a href="https://github.com/CandyRGB/ReqHub/blob/main/pubspec.yaml"><img alt="Platform" src="https://img.shields.io/badge/Platform-Windows-0078D4?style=flat-square&logo=windows&logoColor=white" /></a>
</p>

<p align="center">
  <a href="#features">Features</a> ·
  <a href="#getting-started">Getting started</a> ·
  <a href="#development">Development</a> ·
  <a href="docs/architecture.md">Architecture</a>
</p>

<p align="center">
  English · <a href="README.zh-CN.md">简体中文</a>
</p>

ReqHub provides a focused workspace for organizing requests, configuring authentication and request bodies, sending HTTP calls, and inspecting responses.

## Features

- Organize requests in nested collections and open them in tabs.
- Send HTTP requests with common methods, query parameters, headers, and authentication:
  - No authentication
  - Basic authentication
  - Bearer tokens
  - API keys in headers or query parameters
- Configure request bodies as JSON, form data, URL-encoded data, raw text, or binary files.
- Import requests from cURL and export requests back to cURL.
- Inspect response status, timing, size, body, headers, and cookies.
- Persist collections and application settings locally.
- Use light, dark, or system theme settings.
- Localized English and Simplified Chinese interface.

## Requirements

- Windows 10 or later
- Flutter SDK compatible with Dart `^3.11.5`
- Visual Studio with the **Desktop development with C++** workload

## Getting started

Clone the repository and install dependencies:

```bash
git clone https://github.com/CandyRGB/ReqHub.git
cd ReqHub
flutter pub get
```

Run the application on Windows:

```bash
flutter run -d windows
```

To create a Windows release build:

```bash
flutter build windows
```

The application stores user data and settings under `%APPDATA%\ReqHub\` by default.

## Development

Run static analysis and tests before submitting changes:

```bash
flutter analyze
flutter test
```

When changing Freezed or JSON-serializable models, regenerate the related files:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Project structure

```text
lib/
├── config/       # Theme and color configuration
├── l10n/         # English and Simplified Chinese localization
├── models/       # Immutable Freezed data models
├── providers/    # Riverpod application state
├── screens/      # Main and settings screens
├── services/     # HTTP, storage, cURL, and export services
└── widgets/      # Request, response, sidebar, and shared UI components

test/
├── unit/         # Model, provider, and service tests
└── widget_test.dart
```

For a detailed overview of the data flow and provider architecture, see [`docs/architecture.md`](docs/architecture.md).

## Tech stack

- [Flutter](https://flutter.dev/) — cross-platform UI framework
- [Dio](https://pub.dev/packages/dio) — HTTP client
- [Riverpod](https://riverpod.dev/) — state management
- [Freezed](https://pub.dev/packages/freezed) — immutable model generation
- [Fluent UI](https://pub.dev/packages/fluent_ui) — Windows-oriented design language

## Current scope

ReqHub currently targets Windows desktop usage. The project is actively evolving, and API-client capabilities and UI details may continue to change between releases.
