import 'dart:ui';

/// Centralized color constants for the ReqHub UI.
///
/// All hardcoded colors are defined here so they can be adjusted in one place.
///
/// See also:
///   * [ThemeData] for theme-level color tokens via ColorScheme
///   * https://m3.material.io for contrast / accessibility guidelines

/// Preset theme seed colors offered in Settings.
const presetThemeSeeds = <({String label, int value})>[
  (label: 'Blue', value: 0xFF2196F3),
  (label: 'Indigo', value: 0xFF3F51B5),
  (label: 'Teal', value: 0xFF009688),
  (label: 'Green', value: 0xFF4CAF50),
  (label: 'Purple', value: 0xFF673AB7),
  (label: 'Orange', value: 0xFFFF5722),
  (label: 'Slate', value: 0xFF607D8B),
  (label: 'Mono', value: 0xFF757575),
];

// ─── Surface ─────────────────────────────────────────────────────────

const surfaceWhite = Color(0xFFFFFFFF);
const surfaceDark = Color(0xFF1E1E1E);
const surfaceSidebar = Color(0xFFF3F3F3);

// ─── Border ──────────────────────────────────────────────────────────

const borderLight = Color(0xFFE0E0E0);
const borderSubtle = Color(0x1A000000); // 10 % black

// ─── Text ────────────────────────────────────────────────────────────

const textMuted = Color(0xFF888888);
const textError = Color(0xFFF44336);

// ─── HTTP method badges ──────────────────────────────────────────────

const methodGet = Color(0xFF2196F3);
const methodPost = Color(0xFF4CAF50);
const methodPut = Color(0xFFFF9800);
const methodPatch = Color(0xFFFFC107);
const methodDelete = Color(0xFFF44336); // same as textError
const methodHead = Color(0xFF9C27B0);
const methodOptions = Color(0xFF795548);
const methodDefault = Color(0xFF607D8B);

// ─── HTTP status codes ───────────────────────────────────────────────

const statusSuccess = Color(0xFF4CAF50); // 2xx — same as methodPost
const statusRedirect = Color(0xFFFF9800); // 3xx — same as methodPut
const statusClientError = Color(0xFFF44336); // 4xx — same as textError
const statusServerError = Color(0xFFD32F2F); // 5xx
const statusDefault = Color(0xFF607D8B); // same as methodDefault

// ─── Icons ───────────────────────────────────────────────────────────

const iconFolder = Color(0xFFD4A017);

// ─── Accent ───────────────────────────────────────────────────────────

const accentBlue = Color(0xFF0078D4);

// ─── Actions ─────────────────────────────────────────────────────────

const destructiveRed = Color(0xFFC42B1C);

// ─── Selection & hover overlays ──────────────────────────────────────

const overlayHover = Color(0x11000000); // 6.7 % black
const overlaySelected = Color(0x19000000); // 10 % black
const overlayTreeHover = Color(0x0A000000); // 4 % black

// ─── Depth ───────────────────────────────────────────────────────────

const shadowMenu = Color(0x33000000); // 20 % black
