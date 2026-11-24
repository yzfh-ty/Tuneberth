import 'package:flutter/material.dart';

abstract final class AppTheme {
  static const transitionDuration = Duration(milliseconds: 200);
  static const compactBreakpoint = 880.0;
  static const cornerRadius = 12.0;

  static final light = _build(Brightness.light);
  static final dark = _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final dark = brightness == Brightness.dark;
    final background = Color(dark ? 0xFF0A0A0B : 0xFFF4F4F5);
    final surface = Color(dark ? 0xFF161618 : 0xFFFFFFFF);
    final raised = Color(dark ? 0xFF242427 : 0xFFE9E9EC);
    final text = Color(dark ? 0xFFFAFAFA : 0xFF111113);
    final secondary = Color(dark ? 0xFFB3B3B8 : 0xFF5F5F66);
    final border = Color(dark ? 0xFF343438 : 0xFFD2D2D6);
    final scheme = ColorScheme.fromSeed(seedColor: text, brightness: brightness)
        .copyWith(
          primary: text,
          onPrimary: background,
          primaryContainer: raised,
          onPrimaryContainer: text,
          secondary: secondary,
          onSecondary: background,
          secondaryContainer: raised,
          onSecondaryContainer: text,
          tertiary: secondary,
          onTertiary: background,
          tertiaryContainer: raised,
          onTertiaryContainer: text,
          surface: surface,
          onSurface: text,
          onSurfaceVariant: secondary,
          surfaceContainer: raised,
          surfaceContainerHighest: raised,
          outline: border,
          outlineVariant: border,
          error: const Color(0xFFEF4444),
          surfaceTint: Colors.transparent,
        );

    final theme = ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      fontFamilyFallback: const [
        'Microsoft YaHei UI',
        'Microsoft YaHei',
        'Noto Sans CJK SC',
        'Segoe UI',
        'Roboto',
      ],
      dividerColor: border,
      visualDensity: VisualDensity.standard,
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: text,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 76,
        backgroundColor: surface,
        indicatorColor: raised,
        surfaceTintColor: Colors.transparent,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(0, 48),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(cornerRadius),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(0, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(cornerRadius),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: raised,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(cornerRadius),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );

    return theme.copyWith(
      textTheme: theme.textTheme.apply(bodyColor: text, displayColor: text),
    );
  }
}
