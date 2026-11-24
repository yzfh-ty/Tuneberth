import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tuneberth/app/app.dart';

void main() {
  for (final size in [
    const Size(375, 812),
    const Size(768, 1024),
    const Size(1280, 800),
  ]) {
    testWidgets('navigation and settings fit ${size.width}x${size.height}', (
      tester,
    ) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = size;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const TuneberthApp());
      await tester.pumpAndSettle();
      expect(find.text('你的音乐库还没有歌曲'), findsOneWidget);
      expect(tester.takeException(), isNull);

      await tester.tap(find.text('管理音乐来源'));
      await tester.pumpAndSettle();
      expect(find.text('界面主题'), findsOneWidget);
      expect(find.text('尚未连接账号'), findsOneWidget);
      expect(tester.takeException(), isNull);

      await tester.tap(find.byKey(const ValueKey('navigation-favorites')));
      await tester.pumpAndSettle();
      expect(find.text('还没有收藏的歌曲'), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('navigation-playlists')));
      await tester.pumpAndSettle();
      expect(find.text('你的歌单会出现在这里'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('theme switch keeps navigation and changes brightness', (
    tester,
  ) async {
    await tester.pumpWidget(const TuneberthApp());
    await tester.pumpAndSettle();

    BuildContext shellContext() => tester.element(find.byType(Scaffold));
    expect(Theme.of(shellContext()).brightness, Brightness.dark);

    await tester.tap(find.byKey(const ValueKey('theme-toggle')));
    await tester.pumpAndSettle();
    expect(Theme.of(shellContext()).brightness, Brightness.light);
    expect(find.text('你的音乐库还没有歌曲'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
