import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_shell.dart';
import 'app_theme.dart';

class TuneberthApp extends StatefulWidget {
  const TuneberthApp({super.key});

  @override
  State<TuneberthApp> createState() => _TuneberthAppState();
}

class _TuneberthAppState extends State<TuneberthApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  @override
  Widget build(BuildContext context) {
    final reduceMotion = WidgetsBinding
        .instance
        .platformDispatcher
        .accessibilityFeatures
        .disableAnimations;

    return MaterialApp(
      title: '听泊 · Tuneberth',
      debugShowCheckedModeBanner: false,
      locale: const Locale('zh', 'CN'),
      supportedLocales: const [Locale('zh', 'CN'), Locale('en')],
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: _themeMode,
      themeAnimationDuration: reduceMotion
          ? Duration.zero
          : AppTheme.transitionDuration,
      home: AppShell(
        themeMode: _themeMode,
        onThemeModeChanged: (mode) => setState(() => _themeMode = mode),
      ),
    );
  }
}
