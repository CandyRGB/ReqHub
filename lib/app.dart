import 'dart:ui' show AppExitResponse;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

import 'extensions/localization_ext.dart';
import 'l10n/generated/app_localizations.dart';
import 'providers/providers.dart';
import 'screens/main_screen.dart';
import 'screens/settings_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final _router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(path: '/', builder: (context, state) => const MainScreen()),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);

class ReqHubApp extends ConsumerStatefulWidget {
  const ReqHubApp({super.key});

  @override
  ConsumerState<ReqHubApp> createState() => _ReqHubAppState();
}

class _ReqHubAppState extends ConsumerState<ReqHubApp>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// Intercept app exit (e.g. window close on desktop) and prompt if there
  /// are unsaved tabs.
  @override
  Future<AppExitResponse> didRequestAppExit() async {
    final tabsState = ref.read(requestTabsProvider);
    if (!tabsState.tabs.any((t) => t.isDirty)) {
      return AppExitResponse.exit;
    }

    final context = _rootNavigatorKey.currentContext;
    if (context == null) return AppExitResponse.exit;

    final result = await _showExitDialog(
      context,
      tabsState.tabs.where((t) => t.isDirty).length,
    );

    return result == true ? AppExitResponse.exit : AppExitResponse.cancel;
  }

  /// Show a Material dialog asking whether to exit with unsaved changes.
  Future<bool?> _showExitDialog(BuildContext context, int unsavedCount) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(context.l10n.app_exit_title),
        content: Text(context.l10n.app_exit_message(unsavedCount)),
        actions: [
          TextButton(
            child: Text(context.l10n.button_cancel),
            onPressed: () => Navigator.pop(ctx, false),
          ),
          TextButton(
            child: Text(context.l10n.app_exit_exit_without),
            onPressed: () => Navigator.pop(ctx, true),
          ),
          FilledButton(
            child: Text(context.l10n.app_exit_save_all),
            onPressed: () => Navigator.pop(ctx, true),
          ),
        ],
      ),
    );
  }

  static const _desktopRadius = 4.0;
  static const _desktopShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(_desktopRadius)),
  );

  static final _cjkFallback = [
    'Microsoft YaHei', // Windows - Chinese mainland
    'Source Han Sans SC', // alternate
    'Noto Sans SC',
    'sans-serif',
  ];

  ThemeData _buildTheme(Brightness brightness, Color seed) {
    final base = ThemeData(
      useMaterial3: true,
      colorSchemeSeed: seed,
      brightness: brightness,
      cardTheme: CardThemeData(shape: _desktopShape),
      dialogTheme: DialogThemeData(shape: _desktopShape),
      menuTheme: const MenuThemeData(
        style: MenuStyle(
          shape: WidgetStatePropertyAll(_desktopShape),
          visualDensity: VisualDensity.compact,
          elevation: WidgetStatePropertyAll(0),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(shape: _desktopShape),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(shape: _desktopShape),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(shape: _desktopShape),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
        isDense: true,
      ),
      tabBarTheme: const TabBarThemeData(
        indicatorSize: TabBarIndicatorSize.tab,
        dividerHeight: 0,
      ),
    );

    return base.copyWith(
      textTheme: base.textTheme.apply(fontFamilyFallback: _cjkFallback),
      primaryTextTheme: base.primaryTextTheme.apply(
        fontFamilyFallback: _cjkFallback,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(appThemeProvider);
    final locale = ref.watch(localeProvider);
    final themeSeed = ref.watch(themeSeedProvider);

    return MaterialApp.router(
      title: 'ReqHub',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      locale: locale,
      supportedLocales: const [Locale('en'), Locale('zh')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, child) {
        return Material(
          type: MaterialType.canvas,
          child: child ?? const SizedBox.shrink(),
        );
      },
      theme: _buildTheme(Brightness.light, themeSeed),
      darkTheme: _buildTheme(Brightness.dark, themeSeed),
      routerConfig: _router,
    );
  }
}
