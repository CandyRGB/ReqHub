import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// A bundled CJK variable font keeps Chinese 400/500/600/700 weights distinct.
/// Flutter 3.41+ maps FontWeight directly to this font's wght axis.
const appFontFamily = 'ReqHubSans';

// The same CJK face also covers Chinese text inside monospace editors.
const appFontFallback = [
  appFontFamily,
  'Segoe UI',
  'Segoe UI Emoji',
  'Microsoft YaHei UI',
  'sans-serif',
];

void registerAppFontLicenses() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString(
      'assets/fonts/NotoSansSC-OFL.txt',
    );
    yield LicenseEntryWithLineBreaks(['Noto Sans SC'], license);
  });
}
