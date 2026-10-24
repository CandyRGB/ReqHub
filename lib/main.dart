import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'config/app_typography.dart';
import 'providers/providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  registerAppFontLicenses();

  final container = ProviderContainer();
  final storageService = container.read(storageServiceProvider);
  await storageService.init();

  runApp(
    UncontrolledProviderScope(container: container, child: const ReqHubApp()),
  );
}
