import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reqhub/config/app_theme.dart';
import 'package:reqhub/l10n/generated/app_localizations.dart';
import 'package:reqhub/widgets/sidebar/create_split_button.dart';

const toggleKey = ValueKey('create-menu-toggle');
const surfaceKey = ValueKey('create-menu-surface');

Widget host(List<String> calls, {bool reduceMotion = false}) {
  return MaterialApp(
    theme: buildAppTheme(Brightness.light, const Color(0xFF2196F3)),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    locale: const Locale('en'),
    builder: (context, child) => MediaQuery(
      data: MediaQuery.of(context).copyWith(disableAnimations: reduceMotion),
      child: child!,
    ),
    home: Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 48, top: 12),
        child: Align(
          alignment: Alignment.topLeft,
          child: CreateSplitButton(
            onNewRequest: () => calls.add('request'),
            onNewCollection: () => calls.add('collection'),
            onImportCurl: () => calls.add('curl'),
          ),
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('Menu aligns with the full split button and has equal insets', (
    tester,
  ) async {
    await tester.pumpWidget(host([]));
    final button = tester.getRect(find.byType(CreateSplitButton));
    await tester.tap(find.byKey(toggleKey));
    await tester.pumpAndSettle();

    final menu = tester.getRect(find.byKey(surfaceKey));
    final items = find.byType(MenuItemButton);
    final first = tester.getRect(items.first);
    final last = tester.getRect(items.last);
    expect(menu.left, closeTo(button.left, 0.1));
    expect(menu.top, closeTo(button.bottom + 4, 0.1));
    for (final inset in [
      first.left - menu.left,
      menu.right - first.right,
      first.top - menu.top,
      menu.bottom - last.bottom,
    ]) {
      expect(inset, closeTo(4, 0.1));
    }
  });

  testWidgets('Menu reveals downwards with a fixed top edge and width', (
    tester,
  ) async {
    await tester.pumpWidget(host([]));
    await tester.tap(find.byKey(toggleKey));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 40));
    final during = tester.getRect(find.byKey(surfaceKey));
    await tester.pumpAndSettle();
    final after = tester.getRect(find.byKey(surfaceKey));
    expect(during.height, greaterThan(0));
    expect(during.height, lessThan(after.height));
    expect(during.width, closeTo(after.width, 0.1));
    expect(during.top, closeTo(after.top, 0.1));
  });

  testWidgets('Actions run once and dismiss the menu', (tester) async {
    final calls = <String>[];
    await tester.pumpWidget(host(calls));
    for (final action in [
      ('New Request', 'request'),
      ('New Collection', 'collection'),
      ('Import from cURL', 'curl'),
    ]) {
      await tester.tap(find.byKey(toggleKey));
      await tester.pumpAndSettle();
      await tester.tap(find.text(action.$1));
      await tester.pumpAndSettle();
      expect(calls.last, action.$2);
      expect(find.byKey(surfaceKey), findsNothing);
    }
    expect(calls, ['request', 'collection', 'curl']);
    await tester.tap(find.byType(FilledButton));
    expect(calls, ['request', 'collection', 'curl', 'request']);
  });

  testWidgets('Escape, outside tap and repeated toggle dismiss the menu', (
    tester,
  ) async {
    await tester.pumpWidget(host([]));
    for (final dismiss in ['escape', 'outside', 'toggle']) {
      await tester.tap(find.byKey(toggleKey));
      await tester.pumpAndSettle();
      if (dismiss == 'escape') {
        await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      } else if (dismiss == 'outside') {
        await tester.tapAt(const Offset(500, 400));
      } else {
        await tester.tap(find.byKey(toggleKey));
      }
      await tester.pumpAndSettle();
      expect(find.byKey(surfaceKey), findsNothing, reason: dismiss);
    }
  });

  testWidgets('Keyboard selection and reduced motion are supported', (
    tester,
  ) async {
    final calls = <String>[];
    await tester.pumpWidget(host(calls, reduceMotion: true));
    await tester.tap(find.byKey(toggleKey));
    await tester.pump();
    expect(tester.getSize(find.byKey(surfaceKey)).height, greaterThan(90));
    await tester.pumpAndSettle();
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pumpAndSettle();
    expect(calls, ['collection']);
    expect(find.byKey(surfaceKey), findsNothing);
  });
}
