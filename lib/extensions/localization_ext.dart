import 'package:flutter/widgets.dart';

import '../l10n/generated/app_localizations.dart';

/// Convenience extension so widgets can write [context.l10n] instead of
/// the verbose `AppLocalizations.of(context)!`.
extension LocalizationBuildContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
